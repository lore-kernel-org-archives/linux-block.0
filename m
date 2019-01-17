Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634BBC43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 09:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EC42054F
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 09:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="V/t4hTHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfAQJky (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:40:54 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:51454 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfAQJkx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 04:40:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 3D9B6ABB85;
        Thu, 17 Jan 2019 10:40:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1547718052; i=@fjfi.cvut.cz;
        bh=G7+rdDuA/inGcCz3PtDtqAQ3Ba6G1gLeDOe0nzC9sPw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=V/t4hTHEHZJD8mKh9Kt8vaL4O5KBG/ythVzRz7jxE7BzHRecx8gnNWDAqqSWZhYc7
         R6YQKXKpMjHMhFCYoJquceKNI+Uf0Uh3DnfxFhhd8qpsDfDH11DTv6txnHJroyr2IA
         DNMzE55Ma4gQ2UjtqaFNE/D9SWmqpN/DXwqlDZOI=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id QiiHQJmMOFno; Thu, 17 Jan 2019 10:40:49 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id B48EFABB7D;
        Thu, 17 Jan 2019 10:40:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz B48EFABB7D
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id 729C86004E; Thu, 17 Jan 2019 10:40:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by linux.fjfi.cvut.cz (Postfix) with ESMTP id 625476002A;
        Thu, 17 Jan 2019 10:40:49 +0100 (CET)
Date:   Thu, 17 Jan 2019 10:40:49 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Christoph Hellwig <hch@infradead.org>
cc:     Jens Axboe <axboe@kernel.dk>, Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH 00/16] block: sed-opal: support shadow MBR done flag and
 write
In-Reply-To: <20190117085727.GA14092@infradead.org>
Message-ID: <alpine.LRH.2.21.1901171030320.26315@linux.fjfi.cvut.cz>
References: <20190116225533.BD1396004E@linux.fjfi.cvut.cz> <20190117085727.GA14092@infradead.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 17 Jan 2019, Christoph Hellwig wrote:

> the way the series appear looks odd, because it wasn't threaded or
> even ordered, and the patches from Jonas seem to have been sent out
> by you under his name.  Can you resend them carefully threaded, all
> mails from you with the additional from header for resends?

Ouch. I'm sorry about the ordering/threading. I (wrongly) assumed that if 
I just send the mails in order, that suffices. I'll try to fix that in v2.

W.r.t. "from": Most of the patches were originally created by Jonas. I 
touched some in order to apply review suggestions or make some small 
fixes. But some stayed identical to Jonas' version and I didn't want to 
strip him of authorship. I used git format-patch to produce the mails and 
the commit author was propagated to the from header.

What is the proper way when I am not the author?

Best regards,
David

