Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973A6C43219
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 12:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620662084F
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 12:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AZhuFqvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfDZMp4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:45:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38110 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZMp4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 08:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=akHd8JqiMAzxrz2WCE0z9Z8wSwIAjNmdXhzSk4evgGw=; b=AZhuFqvb56ZemhjhPqPx8RzlB
        DHLTZNxiXAREhfS6hcQN84QTKvH+1PpWmT3ZWfsXF+elp2AQmuYMqGB2t3FEbi0ghPRncdVSagaUg
        smuSONJ+ayLRN+gwNnSaVtu/M7pIk1lzVenHes52Rp0bV1GYl1e5fx3YIjo4uYepzFcszxh3NyQuI
        6BJ994ZTbSsB/zVBP8yoQ04uSFpxPPUImZBAYzRQMwjI3NfjMEhuXJrp1MHliAIYRWty+euxnpKua
        qZKTJVagxc4Kmqtc601X8scFFP7/0W6OCj1Src9tP32GYwPDBknVCaZ7Va2LSJJEgOXC8jpQR+kyy
        s6+S28swg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hK0Ej-0007PV-L6; Fri, 26 Apr 2019 12:45:53 +0000
Date:   Fri, 26 Apr 2019 05:45:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] Direct block mapping through fs for device
Message-ID: <20190426124553.GB12339@infradead.org>
References: <20190426013814.GB3350@redhat.com>
 <20190426062816.GG1454@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426062816.GG1454@dread.disaster.area>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 26, 2019 at 04:28:16PM +1000, Dave Chinner wrote:
> i.e. go look at how xfs_pnfs.c works to hand out block mappings to
> remote pNFS clients so they can directly access the underlying
> storage. Basically, anyone wanting to map blocks needs a file layout
> lease and then to manage the filesystem state over that range via
> these methods in the struct export_operations:
> 
>         int (*get_uuid)(struct super_block *sb, u8 *buf, u32 *len, u64 *offset);
>         int (*map_blocks)(struct inode *inode, loff_t offset,
>                           u64 len, struct iomap *iomap,
>                           bool write, u32 *device_generation);
>         int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
>                              int nr_iomaps, struct iattr *iattr);

Nipick:  get_uuid isn't needed for the least itself, it just works
around the fact that the original pNFS/block protocol is braindead.
The pNFS/SCSI prototocol already switches to a device UUID, and other
users that work locally shouldn't need it either.
