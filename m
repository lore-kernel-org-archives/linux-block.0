Return-Path: <SRS0=XolY=P5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1000BC282DB
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 08:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C285420855
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 08:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bs7HDq84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfAUIdW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:33:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbfAUIdW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jan 2019 03:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3vLTqArO6IlnvIpVNNwtBoC44J5aee9wRIhosCflYV8=; b=bs7HDq84GmSf0zN6cm0CvvZbU
        hr83ehxSwLRzfxBIPX2eo7i24iEE27zN5bqbVeVF9UsC1jK1gg4Sf2pyCgglPhDYfDrFJEnNUuz9V
        BH2Q1PDzIwiKEd01Smjf7TQHg0GwOQsEaaVcd+tc/8u0gIJKjWP7AmfTAXigZkeqSGB5Ut9h2e+fw
        YCcsG2blbVrVExCZGRgEimr95NxNBeqDNdWV8WHWaf7RcYvfTJfAWX++V9ybvGXWHtCjV4XDoX1qV
        ih/ZbglQkXIowNwYL5ncWEINPxeQxOEkpHliKzCc2EllQVuS0I8yNFF9Mcw882VCgTKfVy5vb6sBg
        JsbvsGhDg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glV1B-0007Wk-Gj; Mon, 21 Jan 2019 08:33:17 +0000
Date:   Mon, 21 Jan 2019 00:33:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.com>, Joao Pinto <jpinto@synopsys.com>,
        Fujita Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: dd hangs when reading large partitions
Message-ID: <20190121083317.GA20900@infradead.org>
References: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
 <398a6e83-d482-6e72-5806-6d5bbe8bfdd9@oracle.com>
 <ef734b94-e72b-771f-350b-08d8054a58f3@kernel.dk>
 <20190119095601.GA7440@infradead.org>
 <ea0ebc4b-2634-1f6b-b5cf-0dc1bbb83749@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea0ebc4b-2634-1f6b-b5cf-0dc1bbb83749@acm.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jan 19, 2019 at 08:09:18AM -0800, Bart Van Assche wrote:
> Which patch are you referring to?

a3cd5ec55f6 ("scsi: ufs: add load based scaling of UFS gear")

That being said it doesn't seem entirely trivial to revert due to
later additions, so this might require a little more work.
