Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49327EB64D9
	for <linux-block@archiver.kernel.org>; Mon, 10 Jul 2023 10:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjGJKGz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jul 2023 06:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjGJKGl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 06:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9C23AB8
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 03:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688983340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5RWtnBGzn+0ePdy6QMFHOGeDtAhUqtldpZQ55ephF9w=;
        b=Svd556wUSRIfnJbRnKvoSLeNeNj7vQXB3rpTp2U9L7VHJKOHhLF2uv68kBTojWEHwHp5zO
        kRfvEMx09qI26Q2saKoagTrgaoni0frSl45EIbn19Hjs5cWsPWl5W0fF4p6XamXvP3+QE1
        tfffNN6mrCu3FLjOd3NxO1h6z5Ayfyo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-U4nCc_i4PK2T1djKD9qHNQ-1; Mon, 10 Jul 2023 06:02:17 -0400
X-MC-Unique: U4nCc_i4PK2T1djKD9qHNQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05BB73844FB3;
        Mon, 10 Jul 2023 10:02:17 +0000 (UTC)
Received: from ovpn-8-33.pek2.redhat.com (ovpn-8-33.pek2.redhat.com [10.72.8.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7B9340C2070;
        Mon, 10 Jul 2023 10:02:09 +0000 (UTC)
Date:   Mon, 10 Jul 2023 18:02:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <nmi@metaspace.dk>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        gost.dev@samsung.com, Jens Axboe <axboe@kernel.dk>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>, ming.lei@redhat.com
Subject: Re: [PATCH v6 1/3] ublk: add opcode offsets for DRV_IN/DRV_OUT
Message-ID: <ZKvXHGBiENbFBL3x@ovpn-8-33.pek2.redhat.com>
References: <20230706130930.64283-1-nmi@metaspace.dk>
 <20230706130930.64283-2-nmi@metaspace.dk>
 <51b660f3-8145-d35e-87b4-d9ac0623606d@kernel.org>
 <ZKdjVxMT/sVUA5BV@ovpn-8-34.pek2.redhat.com>
 <ZKuqt6QAXic3wuRX@infradead.org>
 <ZKvO+81b9fAx2L/r@ovpn-8-31.pek2.redhat.com>
 <ZKvQPAN9OkS3dZ4d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKvQPAN9OkS3dZ4d@infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 10, 2023 at 02:32:44AM -0700, Christoph Hellwig wrote:
> On Mon, Jul 10, 2023 at 05:27:23PM +0800, Ming Lei wrote:
> > Yes, that is exactly what we are doing.
> > 
> > The added macros of UBLK_IO_OP_DRV_IN_START[END] are just for supporting
> > more ublk passthrough commands, and the motivation is for running
> > check(such as buffer direction) in two sides easily.
> > 
> > However, I think it is just fine to delay to add it until introducing
> > the 2nd ublk pt command.
> 
> The concept of a passthrough command just doesn't make sense for an
> on the wire protocol.  It is a linux concept that distinguished between
> the Linux synthetic command like REQ_OP_READ/WRITE/DISCARD etc that are
> well defined and can be used by file systems and other consumers, and
> ways to pass through arbitrary blobs only known by the driver.
> 
> Anything in a wire protocol needs to be very well defined in that
> protocol completely indpendent of what Linux concept it maps to.
> Especially as the Linux concepts can change, and fairly frequently do.

Yeah, you are right wrt. linux pt command, and here we shouldn't use
the term of passthrough.

Actually the UAPI is trying to define interface between driver and
userspace, which is just like interface between driver and hardware, such
as, how nvme/sd_zbc is dealing with actual hardware wrt. reporting
zones.

Thanks,
Ming

