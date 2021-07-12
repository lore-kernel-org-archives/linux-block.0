Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A18C07E99
	for <linux-block@archiver.kernel.org>; Mon, 12 Jul 2021 05:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB8F6102A
	for <linux-block@archiver.kernel.org>; Mon, 12 Jul 2021 05:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhGLFab (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jul 2021 01:30:31 -0400
Received: from verein.lst.de ([213.95.11.211]:51066 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230062AbhGLFab (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jul 2021 01:30:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2341467373; Mon, 12 Jul 2021 07:27:40 +0200 (CEST)
Date:   Mon, 12 Jul 2021 07:27:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+118992efda475c16dfb0@syzkaller.appspotmail.com>,
        axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Subject: Re: [syzbot] possible deadlock in loop_add
Message-ID: <20210712052740.GA8599@lst.de>
References: <000000000000ec01e405c6c2cee3@google.com> <20210710131638.605-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210710131638.605-1-hdanton@sina.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jul 10, 2021 at 09:16:38PM +0800, Hillf Danton wrote:
> To break the lock chain, un/register blkdev without mtd_table_mutex held.

Yes, Desmond Cheong Zhi Xi sent pretty much the same patch on June 18th
(mtd: break circular locks in register_mtd_blktrans), but it did not get
picked up.
