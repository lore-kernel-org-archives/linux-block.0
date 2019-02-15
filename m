Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47832C4360F
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 16:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1354521925
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 16:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="OOMDnLC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbfBOQee (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:34:34 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:41604 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfBOQed (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Feb 2019 11:34:33 -0500
Received: by mail-ot1-f45.google.com with SMTP id t7so1102964otk.8
        for <linux-block@vger.kernel.org>; Fri, 15 Feb 2019 08:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=stRk/mHz32PMMHXCbm5ZvfVxRsYZUmUeUqw9cuKRM5A=;
        b=OOMDnLC6WmCzd46ZW+Dl2HFPSydbj8zo7SHQARYjk3eI0f5sYNlPsGCjQdQjQcbhsb
         AQL5/YUC2jg5Hb6W0IfG1nzryFfVOLFXUjzuQeeKq0AV/bqoB754ChPCrzRCGwc+RB77
         HBU4ktBCOjNosCncPG6Co5hWHlPjviF3N8vtXuVjOgTpiQeq8KTU+s9akXL7pZLEA5O0
         w+ws47695peiHcwFuB9g44UwSR33W5p3xhTkp5LFzVMH3sODmZFMHX6DcOGZR8WZz3lA
         prBySzonMbePCYwwN2Douq1yKrPV6GfDPLEhNCChBtq4ACWxBOtgtQCbs0to2E5lLAl4
         EJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=stRk/mHz32PMMHXCbm5ZvfVxRsYZUmUeUqw9cuKRM5A=;
        b=iAvKO2IYcGz0Fk4Ug1T2lIu+ReuUI/TQEKNTglDfus6qAc8XqhqpWjNdJ48YUk0yeX
         +pkgbGp6dYrS7doSdR7WlApSf1ZQ6sCwb7hwrrpgosFJI3OvUBrvhjcg57iL2LxKUAhv
         D08mTHV7/c2XNIscn/PtxRqqfRW3ECELmMt53ofw4+JOslbH5mSLqfeXTbOgUXIY5Smb
         oRAtOqEf9d27kt1xTwf+6Euflu1v2Dnjv1awGlUKLwaXKgF0mQN/NHQH5je4TEh4dpLn
         D1mz+ZssfgQCLU/Yi1wSVMn4At2SfiUaJfZDRxsb7jK4lfW5s0zxSxVsQgvppD05fINz
         y1Og==
X-Gm-Message-State: AHQUAuYsTDj9X6pfiGn8r2u/5JLwgpT4wu7I3h/GdwFDKCgwCT5uG6Qu
        3wbqc9UHAsuQzPJi6yBQwVZMCrk07y0QIf9ua5P+5g==
X-Google-Smtp-Source: AHgI3IbBRhw8TrJ37m4BD6657oUkrvm8niCTcX8mn1Hr/65/RoqkT8dz+R7FV2TYIFC574fl/R2yu+SAhgzIxPw4urc=
X-Received: by 2002:a9d:7493:: with SMTP id t19mr6095897otk.98.1550248473044;
 Fri, 15 Feb 2019 08:34:33 -0800 (PST)
MIME-Version: 1.0
References: <20190215095710.GA12279@linux-x5ow.site>
In-Reply-To: <20190215095710.GA12279@linux-x5ow.site>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 15 Feb 2019 08:34:22 -0800
Message-ID: <CAPcyv4ha4u4Fekee0oKqCTxYrySJEAMW3kVuHsTGHgw7i+5N5w@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] Software RAID Support for NV-DIMM
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>, linux-btrfs@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 15, 2019 at 1:57 AM Johannes Thumshirn <jthumshirn@suse.de> wrote:
>
> (This is a joint proposal with Hannes Reinecke)
>
> Servers with NV-DIMM are slowly emerging in data centers but one key feature
> for reliability of these systems hasn't been addressed up to now, data
> redundancy.
>
> While it would be best to solve this issue in the memory controller of the CPU
> itself, I don't see this coming in the next few years. This puts us as the OS
> in the burden to create the redundant copies of data for the users.
>
> If we leave of the DAX support Linux' software RAID implementations (MD,
> device-mapper and BTRFS RAID) do already work on top of pmem devices, but they
> are incompatible with DAX.
>
> In this session Hannes and I would like to discuss eventual ways how we as an
> operating system can mitigate these issues for our users.

One feature request I have heard in this space is to at least have
filesystem metadata redundancy for DAX. For applications that can
handle their own data-replication the single-point-of-failure FS
metadata becomes a larger liability.
