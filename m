Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A45C3815B
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 11:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C873206D4
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 11:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgDTL7C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:59:02 -0400
Received: from verein.lst.de ([213.95.11.211]:40205 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbgDTL7C (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 07:59:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E578968C65; Mon, 20 Apr 2020 13:58:56 +0200 (CEST)
Date:   Mon, 20 Apr 2020 13:58:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] bdi: add a ->dev_name field to struct
 backing_dev_info
Message-ID: <20200420115856.GA12115@lst.de>
References: <20200416165453.1080463-1-hch@lst.de> <20200416165453.1080463-4-hch@lst.de> <20200417085909.GA12234@quack2.suse.cz> <20200417130135.GB5053@lst.de> <e02b7cdc-f29a-916c-d923-224a1b312485@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e02b7cdc-f29a-916c-d923-224a1b312485@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 20, 2020 at 01:41:57PM +0200, Hans de Goede wrote:
> AFAICT for vboxsf the bdi-name can be anything as long as it is unique, hence
> the "vboxsf-" prefix to make this unique vs other block-devices and the
> ".%d" postfix is necessary because the same export can be mounted multiple
> times (without using bind mounts), see:
> https://github.com/jwrdegoede/vboxsf/issues/3

Shouldn't vboxsf switch to get_tree_single instead of get_tree_nodev?
Having two independent dentry trees for a single actual file system
can be pretty dangerous.

>
> The presence of the source inside the bdi-name is only for informational
> purposes really, so truncating that should be fine, maybe switch to:
>
> "vboxsf%d-%s" as format string and swap the sbi->bdi_id and fc->source
> in the args, then if we truncate anything it will be the source (which
> as said is only there for informational purposes) and the name will
> still be guaranteed to be unique.

Can we just switch to vboxsf%d where %d іs a simple monotonically
incrementing count?  That is what various other file systems (e.g. ceph)
do.
