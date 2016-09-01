Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:43180 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752614AbcIAPKH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Sep 2016 11:10:07 -0400
Message-ID: <1472742605.2569.23.camel@HansenPartnership.com>
Subject: Re: Time to make dynamically allocated devt the default for scsi
 disks?
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Date: Thu, 01 Sep 2016 08:10:05 -0700
In-Reply-To: <cf141c9f-2bda-060a-0a7d-86638c2f5818@sandisk.com>
References: <CAPcyv4jK8W52ss2FhJDa=95B_1q8Szv4AmH0f7p_jzyfEXv0Ag@mail.gmail.com>
         <1471047451.2407.95.camel@HansenPartnership.com>
         <CAPcyv4jqEaBY1atyrjG3G4PYOzaoLvAMfHgK1PD0Si=MRRwAuw@mail.gmail.com>
         <CAPcyv4i=85fCAm1A5Zh2+nYSw7vwXOD=i-B0g4m2eJ+XkEW3tw@mail.gmail.com>
         <1471101800.2397.9.camel@HansenPartnership.com>
         <CAPcyv4gDw49gZBO=Y+K9krgth68OUHcs8urGDNXiZzLNa6kotg@mail.gmail.com>
         <1471110212.2397.39.camel@HansenPartnership.com>
         <CAPcyv4gHq=RraHgcJGx_txk7YJHC8YQ3gCT4CHL0hvzsGpU1wg@mail.gmail.com>
         <1471195252.2355.18.camel@HansenPartnership.com>
         <cf141c9f-2bda-060a-0a7d-86638c2f5818@sandisk.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 2016-08-29 at 11:16 -0700, Bart Van Assche wrote:
> On 08/14/2016 10:21 AM, James Bottomley wrote:
> > diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> > index d3e852a..222771d 100644
> > --- a/drivers/scsi/sd.c
> > +++ b/drivers/scsi/sd.c
> > @@ -3000,7 +3000,13 @@ static void sd_probe_async(void *data,
> > async_cookie_t cookie)
> >  	}
> >  
> >  	blk_pm_runtime_init(sdp->request_queue, dev);
> > -	device_add_disk(dev, gd);
> > +	/*
> > +	 * previously the parent of the gendisk was the scsi
> > device.  It
> > +	 * was moved to fix lifetime rules, so now we install a
> > symlink
> > +	 * to the new location of the block class directory
> > +	 */
> > +	device_add_disk(&sdkp->dev, gd);
> > +	WARN_ON(sysfs_add_link_to_group(&dev->kobj, "block", &sdkp
> > ->dev.kobj, "block"));
> >  	if (sdkp->capacity)
> >  		sd_dif_config_host(sdkp);
> >  
> > @@ -3142,6 +3148,7 @@ static int sd_remove(struct device *dev)
> >  
> >  	async_synchronize_full_domain(&scsi_sd_pm_domain);
> >  	async_synchronize_full_domain(&scsi_sd_probe_domain);
> > +	sysfs_remove_link(&dev->kobj, "block");
> >  	device_del(&sdkp->dev);
> >  	del_gendisk(sdkp->disk);
> >  	sd_shutdown(dev);
> 
> Hello James,
> 
> Sorry that it took so long before I could test this patch and
> the previous patch that was posted in this e-mail thread. But I
> did so earlier this morning. What I see is that the following
> warning message is reported frequently:
> 
> WARNING: CPU: 1 PID: 136 at drivers/scsi/sd.c:3009
> sd_probe_async+0x1ce/0x1e0

That's because the link is created too early, I think.  Let me dig into
this; I managed to hose my big device machine, so I'll need time to
resurrect it.

James


