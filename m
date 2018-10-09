Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36810 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeJIQ22 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Oct 2018 12:28:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id l81-v6so527296pfg.3
        for <linux-block@vger.kernel.org>; Tue, 09 Oct 2018 02:12:33 -0700 (PDT)
Subject: Re: [PATCH 2/5] lightnvm: pblk: Helpers for OOB metadata
To: hans.ml.holmberg@owltronix.com, igor.j.konopko@intel.com
Cc: javier@cnexlabs.com, linux-block@vger.kernel.org,
        marcin.dziegielewski@intel.com
References: <20181005133437.25255-1-igor.j.konopko@intel.com>
 <20181005133437.25255-3-igor.j.konopko@intel.com>
 <CANr-nt1Hc88Sm_e7GYpYqbzXa67zQnGjqHgH3aEo2ARKMZEGeg@mail.gmail.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <76595cfc-4f45-8dbe-04ea-0d7bb0352b3d@lightnvm.io>
Date: Tue, 9 Oct 2018 11:12:27 +0200
MIME-Version: 1.0
In-Reply-To: <CANr-nt1Hc88Sm_e7GYpYqbzXa67zQnGjqHgH3aEo2ARKMZEGeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>   };
>>
>>   struct pblk_sec_meta {
>> -       u64 reserved;
>>          __le64 lba;
>>   };
> 
> It's nice to reduce the required metadata size, but this silently
> breaks pblk the on-disk-storage format. We can't have that.
> 
> I suggest breaking out this change as a separate patch that also
> increases SMETA_VERSION_MAJOR and instructs the user via the kernel
> log to migrate the data manually (or factory reset the decice/pblk
> instance).
> 

In that case, we should include the initialization values of the target 
somewhere. E.g., line metadata, or some FTL log to be implemented at 
some point.

Another fix for now will be to keep it as 16b, and do the patch that you 
propose later. Igor, I believe the metadata will fit? 16b per LBA should 
be max 1K in the case of 64 LBAs.
