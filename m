Return-Path: <shli@kernel.org>
Date: Tue, 19 Dec 2017 10:24:52 -0800
From: Shaohua Li <shli@kernel.org>
To: Bruno Wolff III <bruno@wolff.to>
Cc: weiping zhang <zwp10758@gmail.com>, Laura Abbott <labbott@redhat.com>,
	Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	linux-mm@kvack.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	regressions@leemhuis.info, linux-block@vger.kernel.org
Subject: Re: Regression with a0747a859ef6 ("bdi: add error handle for
 bdi_debug_register")
Message-ID: <20171219182452.vpmqpi3yb4g2ecad@kernel.org>
References: <20171214154136.GA12936@wolff.to>
 <CAA70yB6yofLz8pfhxXfq29sYqcGmBYLOvSruXi9XS_HM6mUrxg@mail.gmail.com>
 <20171215014417.GA17757@wolff.to>
 <CAA70yB6spi5c38kFVidRsJVaYc3W9tvpZz6wy+28rK7oeefQfw@mail.gmail.com>
 <20171215111050.GA30737@wolff.to>
 <CAA70yB66ekUGAvusQbqo7BLV+uBJtNz72cr+tZitsfjuVRWuXA@mail.gmail.com>
 <20171215195122.GA27126@wolff.to>
 <20171216163226.GA1796@wolff.to>
 <CAA70yB7wL_Wq5S8XQ9zHuLPDdwepv7dYdKALL8Sg0q6CNdAz5g@mail.gmail.com>
 <20171219161743.GA6960@wolff.to>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171219161743.GA6960@wolff.to>
List-ID: <linux-block@vger.kernel.org>

On Tue, Dec 19, 2017 at 10:17:43AM -0600, Bruno Wolff III wrote:
> On Sun, Dec 17, 2017 at 21:43:50 +0800,
>  weiping zhang <zwp10758@gmail.com> wrote:
> > Hi, thanks for testing, I think you first reproduce this issue(got WARNING
> > at device_add_disk) by your own build, then add my debug patch.
> 
> The problem is still in rc4. Reverting the commit still fixes the problem. I
> tested that warning level messages should appear using lkdtm. While there
> could be something weird relating to the WARN_ON macro, more likely there is
> something different about the boots with the kernels I build (the exact way
> initramfs is built is probably different) and probably that (WARN_ON) code
> is not getting executed.

Not sure if this is MD related, but could you please check if this debug patch
changes anything?

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 4e4dee0..c365179 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -518,7 +518,6 @@ static void mddev_put(struct mddev *mddev)
 	    mddev->ctime == 0 && !mddev->hold_active) {
 		/* Array is not configured at all, and not held active,
 		 * so destroy it */
-		list_del_init(&mddev->all_mddevs);
 		bs = mddev->bio_set;
 		sync_bs = mddev->sync_set;
 		mddev->bio_set = NULL;
@@ -5210,6 +5209,10 @@ static void md_free(struct kobject *ko)
 	}
 	percpu_ref_exit(&mddev->writes_pending);
 
+	spin_lock(&all_mddevs_lock);
+	list_del_init(&mddev->all_mddevs);
+	spin_unlock(&all_mddevs_lock);
+
 	kfree(mddev);
 }
 
