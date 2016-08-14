Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35113 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbcHNSXH (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Sun, 14 Aug 2016 14:23:07 -0400
Received: by mail-oi0-f51.google.com with SMTP id 4so39345430oih.2
        for <linux-block@vger.kernel.org>; Sun, 14 Aug 2016 11:23:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPcyv4i4vyXc-qigqVo9oBL-7n9g4cbhK9Yt0o2F_bCPqMSF1Q@mail.gmail.com>
References: <CAPcyv4jK8W52ss2FhJDa=95B_1q8Szv4AmH0f7p_jzyfEXv0Ag@mail.gmail.com>
 <1471047451.2407.95.camel@HansenPartnership.com> <CAPcyv4jqEaBY1atyrjG3G4PYOzaoLvAMfHgK1PD0Si=MRRwAuw@mail.gmail.com>
 <CAPcyv4i=85fCAm1A5Zh2+nYSw7vwXOD=i-B0g4m2eJ+XkEW3tw@mail.gmail.com>
 <1471101800.2397.9.camel@HansenPartnership.com> <CAPcyv4gDw49gZBO=Y+K9krgth68OUHcs8urGDNXiZzLNa6kotg@mail.gmail.com>
 <1471110212.2397.39.camel@HansenPartnership.com> <CAPcyv4gHq=RraHgcJGx_txk7YJHC8YQ3gCT4CHL0hvzsGpU1wg@mail.gmail.com>
 <1471195252.2355.18.camel@HansenPartnership.com> <CAPcyv4i4vyXc-qigqVo9oBL-7n9g4cbhK9Yt0o2F_bCPqMSF1Q@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 14 Aug 2016 11:23:06 -0700
Message-ID: <CAPcyv4j_R9CZKFXuv1EDqUOMTnAutyQwk_+h1pzC3NKyR6aGVQ@mail.gmail.com>
Subject: Re: Time to make dynamically allocated devt the default for scsi disks?
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-block@vger.kernel.org,
	linux-scsi <linux-scsi@vger.kernel.org>,
	Jens Axboe <axboe@fb.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Bart Van Assche <bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

[ adding Bart back to the cc ]

On Sun, Aug 14, 2016 at 11:08 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Sun, Aug 14, 2016 at 10:20 AM, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
[..]
> I like it.  I still think the bdi registration code should be in
> charge of taking the extra reference on the disk device's parent to
> isolate / make clear why the extra reference is being acquired, but I
> won't lose sleep if Jens takes your smaller change.
>
> Thanks James!

Bart, do you have a test configuration already set up for this case.
Can you give the 2 patches from James a try?

https://patchwork.kernel.org/patch/9278201/
https://patchwork.kernel.org/patch/9279513/
