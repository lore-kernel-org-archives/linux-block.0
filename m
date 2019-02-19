Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DEEC43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 14:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F822146E
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 14:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bg+NNfXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfBSOpA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:45:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfBSOpA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Feb 2019 09:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=21DHr+RSj+xLDKfUOmmwQEe9U8Yhv3wyd3vmDfQBbJ8=; b=Bg+NNfXr8pMNxktAjX0ExkyVv
        lOVOoBcOoNUemoyU0nqmdAKULhDXV51CARXuwixN51/frSvDKHAQyC9gWmOcQUKqwf2LBzaECW/v9
        5T6e7ypytKZM1hjJQ5+vIH+M8S3EH0yWq0te02Qz3+j4NRy0KO+Vj8f+QrbUEO4qRquWe2sd0K4uM
        29InieQC7y/wRfX+gkc/3SA8hQLf7Dk4jUEnQIR7wCmC+fR3QcDWxZGBHnuSnL5fxuP5FEtyfNNWs
        wYYKgm3NuUkjYL6QAE0DtVmUV+Le0h5If2nKRN/8DgwColGlvf/ZNYAjJDstbSPcDoTIROfGBfSDm
        4VliQC82g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gw6di-0007i1-S2; Tue, 19 Feb 2019 14:44:54 +0000
Date:   Tue, 19 Feb 2019 06:44:54 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Meelis Roos <mroos@linux.ee>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-alpha@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: ext4 corruption on alpha with 4.20.0-09062-gd8372ba8ce28
Message-ID: <20190219144454.GB12668@bombadil.infradead.org>
References: <fb63a4d0-d124-21c8-7395-90b34b57c85a@linux.ee>
 <1c26eab4-3277-9066-5dce-6734ca9abb96@linux.ee>
 <076b8b72-fab0-ea98-f32f-f48949585f9d@linux.ee>
 <20190216174536.GC23000@mit.edu>
 <e175b885-082a-97c1-a0be-999040a06443@linux.ee>
 <20190218120209.GC20919@quack2.suse.cz>
 <4e015688-8633-d1a0-308b-ba2a78600544@linux.ee>
 <20190219132026.GA28293@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219132026.GA28293@quack2.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 19, 2019 at 02:20:26PM +0100, Jan Kara wrote:
> Thanks for information. Yeah, that makes somewhat more sense. Can you ever
> see the failure if you disable CONFIG_TRANSPARENT_HUGEPAGE? Because your
> findings still seem to indicate that there' some problem with page
> migration and Alpha (added MM list to CC).

Could
https://lore.kernel.org/linux-mm/20190219123212.29838-1-larper@axis.com/T/#u
be relevant?
