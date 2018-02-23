Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Fri, 23 Feb 2018 11:45:30 +0100
From: Carlos Maiolino <cmaiolino@redhat.com>
To: linux-block@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Thomas Schmitt <scdbackup@gmx.net>,
        skenton@ou.edu
Subject: Re: [PATCH 1/1] extend BLKRRPART to update the readable size of
 optical media
Message-ID: <20180223104530.l2mjyzprh4oyymaj@odin.usersys.redhat.com>
References: <20180222190016.3989-1-skenton@ou.edu>
 <20180223101441.xgeliebkc3yjq5dv@odin.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180223101441.xgeliebkc3yjq5dv@odin.usersys.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Fri, Feb 23, 2018 at 11:14:41AM +0100, Carlos Maiolino wrote:
> On Thu, Feb 22, 2018 at 01:00:16PM -0600, Steve Kenton wrote:
> > The readable size of new, factory blank, optical media can change via user space ioctl(SG_IO) commands to format overwritable media such as DVD+RW for a UDF filesystem or write to sequential media such as DVD-R for an ISO-9660 filesystem. However there appears to be no easy way to update the size used by the block layer from the initial value of zero other than ejecting and reinserting the media. This is a long standing issue which programs such as growisofs work around by automatically opening and closing the tray at the end of a session so the newly created filesystem becomes mountable/readable. This can be problematic when using a slot load drive.
> > 

This should go to linux- block btw, not linux-fsdevel, cc'ing them

> > Making the BLKRRPART ioctl call fops->revalidate_disk() => sr_revalidate_disk() in sr.c resolves the issue for optical media and should be a rare and benign operation if ever called for non-optical media => sd_revalidate_disk() in sd.c.
> > 
> 
> Please use checkpatch.pl and break the comment description to at most
> 80chars/line
> 
> > Signed-off-by: Steve Kenton <skenton@ou.edu>
> > Signed-off-by: Thomas Schmitt <scdbackup@gmx.net>
> > ---
> > I discussed this with Thomas Schmitt the maintainer of the xorriso burner program to define the problem and suggest a fix.
> > 
> > Loading  a factory blank DVD+RW needing to be "de-iced" gives the results below before and after format full using xorriso but *NOT* ejecting the media
> > 
> > hdi@hdi-H110N:/sys/block/sr0$ dd if=/dev/sr0 of=/dev/null bs=2k
> > dd: error reading ‘/dev/sr0’: Input/output error
> > 0+0 records in
> > 0+0 records out
> > 0 bytes (0 B) copied, 0.0275589 s, 0.0 kB/s
> > 
> > hdi@hdi-H110N:/sys/block/sr0$ cat size
> > 4
> > 
> > hdi@hdi-H110N:/sys/block/sr0$ xorriso -dev /dev/sr0 -format full
> > 
> > hdi@hdi-H110N:/sys/block/sr0$ dd if=/dev/sr0 of=/dev/null bs=2k
> > 0+0 records in
> > 0+0 records out
> > 0 bytes (0 B) copied, 0.000280081 s, 0.0 kB/s
> > 
> > hdi@hdi-H110N:/sys/block/sr0$ cat size
> > 0
> > 
> > Here are the results after deleting and then rescanning the optial drive via sysfs
> > echo offline > state  echo 1 > delete  echo - - - > scan
> > *WITHOUT* ejecting the media
> > 
> > hdi@hdi-H110N:/sys/block/sr0/device$ dd if=/dev/sr0 of=/dev/null bs=2k count=1
> > 1+0 records in
> > 1+0 records out
> > 2048 bytes (2.0 kB) copied, 0.0624783 s, 32.8 kB/s
> > 
> > hdi@hdi-H110N:/sys/block/sr0$ cat size
> > 9180416
> > 
> > With this patch applied running a small program to perform ioctl(BLKRRPART) on /dev/sr0 produces similar results with a blank DVD-R after writing to the disc using xorriso. Again, *WITHOUT* ejecting and reinserting the media. Much nicer than the spin down and delete then scan for the device again business, I think :-)
> > 
> > hdi@hdi-H110N:/sys/block/sr0$ cat size
> > 4
> > 
> > ./blkrrpart /dev/sr0
> > 
> > hdi@hdi-H110N:/sys/block/sr0$ cat size
> > 16256
> > 
> > 
> >  block/ioctl.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/ioctl.c b/block/ioctl.c
> > index 1668506d8ed8..da79e9ba44ba 100644
> > --- a/block/ioctl.c
> > +++ b/block/ioctl.c
> > @@ -163,14 +163,18 @@ int __blkdev_reread_part(struct block_device *bdev)
> >  {
> >  	struct gendisk *disk = bdev->bd_disk;
> >  
> > -	if (!disk_part_scan_enabled(disk) || bdev != bdev->bd_contains)
> > +	if (bdev != bdev->bd_contains) // must be whole disk
> 
> 					^^ /*  Comment */
> >  		return -EINVAL;
> > +
> >  	if (!capable(CAP_SYS_ADMIN))
> >  		return -EACCES;
> >  
> >  	lockdep_assert_held(&bdev->bd_mutex);
> >  
> > -	return rescan_partitions(disk, bdev);
> > +	if (disk_part_scan_enabled(disk))
> > +		return rescan_partitions(disk, bdev);
> > +	else // update size but not partitions, could be sr or sd
> 
> 		^^ /* Comment */
> > +		return disk->fops->revalidate_disk(disk);
> 
> and what happens if a device without ->revalidate_disk() defined calls into this
> function?
> 
> >  }
> >  EXPORT_SYMBOL(__blkdev_reread_part);
> >  
> > -- 
> > 2.16.1.72.g5be1f00
> > 
> 
> -- 
> Carlos

-- 
Carlos
