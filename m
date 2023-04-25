Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BC5C77B61
	for <linux-block@archiver.kernel.org>; Tue, 25 Apr 2023 22:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjDYWjH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Apr 2023 18:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236251AbjDYWjH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Apr 2023 18:39:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093A71447C
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 15:39:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B22861F87
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 22:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1E7C433D2;
        Tue, 25 Apr 2023 22:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682462345;
        bh=+KbQYreuBWZGdnYLBpWBEmXnrxzZCsmAHyaRTByu+Sg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fkF46wo8cJe6a+o5JYXyRfN+20QQj5ZGKZcTpoXDPTMEwPURv4HOXwdlXREd18RTm
         A5Az8cFDeQENE6iVJXE88Ik2sdcicIv2/4BJ7HPsTdxsXF/jojMWNaBcUOrsA3dP7j
         qlbtOMfXTQIE+/veV6jSExlLcts/zIcEmsTj09Ja0RlDZhMshwpmf92Wtq9bvogzDT
         zVVnkbRZxAFSBR9hEGNp9f/vYcO6xaulC7TbIHVzhx5Ijnw2JTmmBLP+MgbLSZGEpK
         kqLAo1uEKAotivdYG/pJOCHWUQeGQUUAh8v9YpYgUBvqknDxeIZhKgl8h2L1P22R+J
         RuKFgwzWb46Og==
Date:   Tue, 25 Apr 2023 16:39:01 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>, hch@lst.de,
        sagi@grimberg.me, linux-nvme@lists.infradead.org, hare@suse.de,
        axboe@kernel.dk, linux-block@vger.kernel.org, oren@nvidia.com,
        oevron@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH v2 2/2] nvme-multipath: fix path failover for integrity ns
Message-ID: <ZEhWhegPXHYSCJJo@kbusch-mbp.dhcp.thefacebook.com>
References: <20230424225442.18916-1-mgurtovoy@nvidia.com>
 <20230424225442.18916-3-mgurtovoy@nvidia.com>
 <yq1jzy0lnyl.fsf@ca-mkp.ca.oracle.com>
 <85974694-c544-be82-97ce-c318adacda49@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85974694-c544-be82-97ce-c318adacda49@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 25, 2023 at 01:24:31PM +0300, Max Gurtovoy wrote:
> 
> 
> On 25/04/2023 5:12, Martin K. Petersen wrote:
> > 
> > Hi Max!
> > 
> > > In case the integrity capabilities of the failed path and the failover
> > > path don't match, we may run into NULL dereference. Free the integrity
> > > context during the path failover and let the block layer prepare it
> > > again if needed during bio_submit.
> > 
> > This assumes that the protection information is just an ephemeral
> > checksum. However, that is not always the case. The application may
> > store values in the application or storage tags which must be returned
> > on a subsequent read.
> 
> Interesting.
> 
> Maybe you can point me to this API that allow applications to store
> application tag in PI field ?

I think Martin might be considering kernel modules as apps since they can
access the integrity payload no problem. I know of at least one out-of-tree
module (ex: OpenCAS) that utilizes the apptag (not that upstream necessarily
should care about such modules..).

Outside that, passthrough ioctls and io_uring_cmd can access the fields. I
don't think those interfaces apply to what you're changing, though, since these
bypass the submit_bio() interface.
 
> I see that app_tag is 0 in Linux and we don't set the nvme_cmd->apptag to
> non zero value.
> It's been a while since I was working on this so I might be wrong here :).
> 
> I've noticed that in t10_pi_generate and ext_pi_crc64_generate we set it to
> 0 as well.
> 
> The way I see it now, and I might be wrong, is that the Linux kernel is not
> supporting application to store apptag values unless it's using some
> passthrough command.

If we're considering only in-tree usage, I think you're correct.

> > In addition, in some overseas markets (financial, government), PI is a
> > regulatory requirement. It would be really bad for us to expose a device
> > claiming PI support and then it turns out the protection isn't actually
> > always active.
> > 
> > DM multipathing doesn't allow mismatched integrity profiles. I don't
> > think NVMe should either.
> > 
> 
> AFAIU, the DM multipath is not a specification but a Linux implementation.
> NVMe multipathing follows a standard.

If we're talking about any of the nvme passthrough interfaces, which format
will the user space need to construct its command for? This seems confusing
since userspace doesn't have direct control over which path the command will be
dispatched on, so it won't know which format it needs to cater to, nor will it
have deterministic behavior.
