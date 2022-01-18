Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD480C433F5
	for <linux-block@archiver.kernel.org>; Tue, 18 Jan 2022 08:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240071AbiARIXE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jan 2022 03:23:04 -0500
Received: from verein.lst.de ([213.95.11.211]:36022 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238593AbiARIXD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jan 2022 03:23:03 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 60C6C68B05; Tue, 18 Jan 2022 09:23:00 +0100 (CET)
Date:   Tue, 18 Jan 2022 09:22:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] block: move freeing disk into queue's release
 handler
Message-ID: <20220118082259.GA21847@lst.de>
References: <20220116041815.1218170-1-ming.lei@redhat.com> <20220116041815.1218170-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220116041815.1218170-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

How does this work for SCSI where we can detach the disk from the
request queue, reattach it and then maybe later free them both?
