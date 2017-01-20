Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mgwym04.jp.fujitsu.com ([211.128.242.43]:29663 "EHLO
        mgwym04.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751740AbdATJsA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2017 04:48:00 -0500
Date: Fri, 20 Jan 2017 18:24:48 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [LSF/MM TOPIC] Badblocks checking/representation in filesystems
Cc: Lu Zhang <luzh@eng.ucsd.edu>, Andreas Dilger <adilger@dilger.ca>,
        Slava Dubeyko <Vyacheslav.Dubeyko@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Andiry Xu <andiry@gmail.com>,
        "lsf-pc@lists.linux-foundation.org"
        <lsf-pc@lists.linux-foundation.org>
In-Reply-To: <20170120004633.GA14128@omniknight.lm.intel.com>
References: <CAL4pJv6MvJhTuPJbPAV-HXGrMST-dJs461O=wwfcpdvQA-amdA@mail.gmail.com> <20170120004633.GA14128@omniknight.lm.intel.com>
Message-Id: <20170120182435.0E12.E1E9C6FF@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,
Virshal-san.

First of all, your discussion is quite interesting for me. Thanks.

> > 
> > If DUE does happen and is flagged to the file system via MCE (somehow...),
> > and the fs finds that the error corrupts its allocated data page, or
> > metadata, now if the fs wants to recover its data the intuition is that
> > there needs to be a stronger error correction mechanism to correct the
> > hardware-uncorrectable errors. So knowing the hardware ECC baseline is
> > helpful for the file system to understand how severe are the faults in
> > badblocks, and develop its recovery methods.
> 
> Like mentioned before, this discussion is more about presentation of
> errors in a known consumable format, rather than recovering from errors.
> While recovering from errors is interesting, we already have layers
> like RAID for that, and they are as applicable to NVDIMM backed storage
> as they have been for disk/SSD based storage.

I have one question here.

Certainly, user can use LVM mirroring for storage mode of NVDIMM.
However, NVDIMM has DAX mode. 
Can user use LVM mirroring for NVDIMM DAX mode?
I could not find any information that LVM support DAX....

In addition, current specs of NVDIMM (*) only define interleave feature of NVDIMMs. 
They does not mention about mirroring feature.
So, I don't understand how to use mirroring for DAX.

(*) "NVDIMM Namespace Specification" , "NVDIMM Block Window Driver Writer’s Guide",
       and "ACPI 6.1"

Regards,
---
Yasunori Goto

