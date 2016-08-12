Return-Path: <linux-scsi-owner@vger.kernel.org>
Subject: Re: Time to make dynamically allocated devt the default for scsi
 disks?
To: Dan Williams <dan.j.williams@intel.com>,
	<linux-block@vger.kernel.org>,
	linux-scsi <linux-scsi@vger.kernel.org>
References: <CAPcyv4jK8W52ss2FhJDa=95B_1q8Szv4AmH0f7p_jzyfEXv0Ag@mail.gmail.com>
CC: Jens Axboe <axboe@fb.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Jej B <James.Bottomley@hansenpartnership.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <0ac6429a-97c3-c64f-2ad1-be9ddf77ab8d@sandisk.com>
Date: Fri, 12 Aug 2016 14:35:45 -0700
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jK8W52ss2FhJDa=95B_1q8Szv4AmH0f7p_jzyfEXv0Ag@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On 08/12/2016 02:29 PM, Dan Williams wrote:
> ...or, for that matter, any block device driver on a bus that supports hotplug?
>
> In 4.8 Jens merged the following fix for a crash that was triggered by
> repeatedly reconfiguring a libnvdimm namespace causing it to destroy
> and create disks (rapid hotplug).
>
>     df08c32ce3be block: fix bdi vs gendisk lifetime mismatch
>
> At the time I realized that the fix only addressed block device
> drivers that use a dynamic devt and theorized that we still have a
> problem with static devt drivers like sd.  Lo and behold Dave was
> bitten by this exact scenario:
>
>  WARNING: CPU: 23 PID: 9672 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x62/0x80
>  sysfs: cannot create duplicate filename '/devices/virtual/bdi/8:16'
>  [..]
>  CPU: 23 PID: 9672 Comm: kworker/u66:2 Tainted: G          I
> 4.6.3-300.fc24.x86_64 #1
> [ ... ]
>
> Before spending effort trying to flush the destruction of old bdi
> instances before new ones are registered, is it rather time to
> complete the conversion of sd to only use dynamically allocated devt?

Hello Dan,

Sorry but I'm not familiar with dynamically allocated devt's. But I 
would appreciate it if Dave could test the following patch: "Fix an sd 
reregistration race, v5" (https://patchwork.kernel.org/patch/9178155/).

Thanks,

Bart.
