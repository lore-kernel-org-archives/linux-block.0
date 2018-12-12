Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EC9C04EB8
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 07:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B9420851
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 07:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gnlWnAuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B9420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbeLLHk0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:40:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32984 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeLLHk0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 02:40:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eHqUA0unzhshg6D/ZSy6JQsAt90GWbJdG61sWGRDID8=; b=gnlWnAuUUPgQTa43S3VD5Yg82
        n+oqGSYk3sCXhfgZLkd0f3h/tcsjVfWiDaQjuLgxGzf/plSpsz9/HCgJFKWnMDTHincbFsDR4YQyD
        LVBjvPTdWnbyinCd2KHS6gh9NjlxOznbbrE/zpCFCreQNoYP6paG1/noL2uFZlFBsb/QVSdThgSaW
        BDaQtlKUamb2C1H4x9Xw3d0vpM1EUSzoOIVzKC++LvTu5Zom4Ldb14Q46bwpvgcPKL7oPQDCDPXkH
        1y+qOurBjCqdgeHYB+67nz91K39nsozloJDtkxKXm9LJ/BXd41dewXzA0hrferkIpphem3q9B8ol1
        quu9oqt4Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWz7x-0000q6-KV; Wed, 12 Dec 2018 07:40:17 +0000
Date:   Tue, 11 Dec 2018 23:40:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Parshuram Raju Thombare <pthombar@cadence.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "tj@kernel.org" <tj@kernel.org>, "jbacik@fb.com" <jbacik@fb.com>,
        "michaelcallahan@fb.com" <michaelcallahan@fb.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "shli@fb.com" <shli@fb.com>,
        "dennisszhou@gmail.com" <dennisszhou@gmail.com>,
        Alan Douglas <adouglas@cadence.com>,
        Janek Kotas <jank@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>
Subject: Re: [PATCH 0/2] scsi: ufs: add real time/inline crypto support to
 UFS HCD
Message-ID: <20181212074017.GA19904@infradead.org>
References: <20181211094910.GA28288@lvlogina.cadence.com>
 <20181211140643.GA6576@infradead.org>
 <CO2PR07MB24692595C49430F56CE5DAC2C1A60@CO2PR07MB2469.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO2PR07MB24692595C49430F56CE5DAC2C1A60@CO2PR07MB2469.namprd07.prod.outlook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 11, 2018 at 06:22:27PM +0000, Parshuram Raju Thombare wrote:
> One reason of using device mapper here is to use existing tools like
> 'dmsetup', otherwise some user space application is needed and may be
> some changes in block layer to pass the crypto information (crypto
> algorithm, key etc) till ufs driver.

Yes, so what?  We also don't use dmsetup to set up TCG OPAL based
encryption either.

> Another reason is supporting multiple UFS devices. I think, as you said
> UFS crypto support can be added by some change in ufs driver and block
> layer glue. But to support multiple UFS crypto devices having different
> crypto configs (crypto algorithms, key size etc), crypto context need to
> be saved per crypto device which may need some changes in block layer code.

I don't think we need device mapper for that.  We can hav the crypto
state hanging off the ufs host, or request_queue if we decide to
implement it generic in the block layer.
