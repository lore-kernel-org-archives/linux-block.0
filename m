Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08ADAC04AAF
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 12:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F2E217D7
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 12:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FeDWO975"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfEUMv3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 May 2019 08:51:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43564 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfEUMv2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 08:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=FeDWO975fNC3Rwlp1Ik8IumWR
        KElWZeU1FzJFkbHDOrfiz4kprdOImDn1SnpES/LvZkL47QoeeS928tvMlNHtFxLNqacnWa4pUiRBZ
        N4/qAAn5bOcw9POmiVKbzP7b5oJ4Ta/dbyQ7Xstfn5wS8M9VOUIU5N4dWzSbZKZK/BolPttr14R47
        qhGoKWpDxPejsZo3Ruwq4cSICjl1nMu+dupmhpkVxDUI7B9FXdN3BNkqqhYeMJAqyOqTGCSsJcxv2
        GlN+wMlHHpG6+QCevouBZKRYhvS14WFh6JQmebgLYMgfdgXAxMSY+YLEwnH9BK6OQwdAvGKLfC9KL
        8wInl9RsA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hT4Eq-0007jp-Fk; Tue, 21 May 2019 12:51:28 +0000
Date:   Tue, 21 May 2019 05:51:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        dm-devel@redhat.com, axboe@kernel.dk, gavin.guo@canonical.com,
        jay.vosburgh@canonical.com, kernel@gpiccoli.net,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Eric Ren <renzhengeek@gmail.com>
Subject: Re: [PATCH V2 1/2] block: Fix a NULL pointer dereference in
 generic_make_request()
Message-ID: <20190521125128.GA16799@infradead.org>
References: <20190520220911.25192-1-gpiccoli@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520220911.25192-1-gpiccoli@canonical.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
