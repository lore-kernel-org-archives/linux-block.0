Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583FBC636CC
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 14:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjBPOkX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 09:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBPOkW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 09:40:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB77311C3
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 06:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PaHvrs3iBsQcNhnMYeNKKFX/2Pob4S55+YkVPxadmnk=; b=KSgP3DkEhnGnup50lRxVxWa0M/
        yrmoF8wzGo9otypYITvDdLwDb2W1I6pTaSy4reXjUFqGjOt+d8929hJYVokATHpnydMNlRGuLaD9O
        oVh5MBwKIIQyN70arMuhFG/KGFiI9scd/20FJEABsOzZjVUwzbtJZ/l1cXli8eetFKiTtY/PkLQzd
        WtDfN7pPxWwUy15CnBV6BM5mY/m6EUN4oxp9RY01kYfIr1xGbSJrJt/3V6zf8PZ7PGtIfo3b1BdJP
        7BeAX9HZ+38sBDQcfTYCNBqasc2ZPtMTuZxB/cnkoYTt9Ey/MQvinemeovdu26oIQul+oHJmisR13
        MI9DujJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSfQq-00AhmE-56; Thu, 16 Feb 2023 14:40:20 +0000
Date:   Thu, 16 Feb 2023 06:40:20 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] brd: mark as nowait compatible
Message-ID: <Y+5AVIhMRRD8ks7X@infradead.org>
References: <776a5fa2-818c-de42-2ac3-a4588df218ca@kernel.dk>
 <Y+3IUcJLNK8WAkov@infradead.org>
 <9a9adcce-81db-580f-843f-ebff7177464c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a9adcce-81db-580f-843f-ebff7177464c@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 16, 2023 at 06:11:41AM -0700, Jens Axboe wrote:
> I did consider that, but we do allocations almost everywhere and

Do we?  All the code I've touched for nowait goes to great length
to avoid blocking allocations.

