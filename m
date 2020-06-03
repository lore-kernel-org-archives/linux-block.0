Return-Path: <SRS0=EWxa=7Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CF0C433DF
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 04:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 699592072F
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 04:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PX8/AEo7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgFCE62 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jun 2020 00:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFCE62 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jun 2020 00:58:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0BEC05BD43;
        Tue,  2 Jun 2020 21:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4hilE/7L5QlGGOsWg+8etgv/113+iSUSl6TGtC/AcDQ=; b=PX8/AEo7bHIzGr1KmB4+ay+aB3
        8I21/1neIEfA/E+ANgo7ymdeT4BMPYcyXt0gNairBfGVvD60ABXHeL2LovBIAoHbaEPoWGOCcinVa
        knfN9pZvH7LURV9bRrSx/SBINQZxv0dAV36UEpv1I1vm3D8iitkVzcgHI/u7vFJV7Xa8tWzdiijxG
        mvEt4+U2NSwaexg1+2hv8gQLRg0P+VN5tsLf3WxsYFXlWInMV1/SDWlz1xCk2zbOPnSpHLhVEKEJH
        GTlQ5PSzIf1/R2mH2DeSd8swKrOl+yLIxAc7r80CQgxbnmfXf3nL5tsbQ5au88bL7XodyWSJ2Xeia
        HxFSAjVw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgLTq-0004Uf-2w; Wed, 03 Jun 2020 04:58:22 +0000
Date:   Tue, 2 Jun 2020 21:58:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 1/3] block: add flag 'nowait_requests' into queue
 limits
Message-ID: <20200603045822.GA17137@infradead.org>
References: <159101473169.180989.12175693728191972447.stgit@buzz>
 <159101502963.180989.6228080995222059011.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159101502963.180989.6228080995222059011.stgit@buzz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 01, 2020 at 03:37:09PM +0300, Konstantin Khlebnikov wrote:
> Add flag for marking bio-based queues which support REQ_NOWAIT.
> Set for all request based (mq) devices.
> 
> Stacking device should set it after blk_set_stacking_limits() if method
> make_request() itself doesn't delay requests or handles REQ_NOWAIT.

I don't think this belongs into the queue limits.  For example a
stacking driver that always defers requests to a workqueue can support
REQ_NOWAIT entirely independent of the underlying devices.  I think
this just needs to be a simple queue flag.
