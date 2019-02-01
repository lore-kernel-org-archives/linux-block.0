Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8A3C282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 16:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0572721726
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 16:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I11JgVPu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbfBAQSH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:18:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54536 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbfBAQSG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 11:18:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7UgOPIZ3DbTxaVZJztihGG0Z9ZH7CeOfk0gJ7D8TTj4=; b=I11JgVPuEEIfS/omg+9qkJcfV
        oPuf4A/UjOqzy3Naq74k2/PbbQPZlQhXcGkaOZHTlWt2bxQuNum527EL7S/+mfCUdQ1ddeW/eucH5
        /DlKP90BOB+ZII19uAoUEhDQ32oGCbHz9F1pa6D+slKSNXq9NTMTfwAMX5q71VVcKH3fvlIsxouoV
        z+DcS6BrPQOI7v8O+xH380RAl6uigBiwiBuV6rzYoH5WtG2jCcSKymCzNcy7nffeKO8iVDWJzHfCJ
        Skqy0KjVXol9rC88cFXjDUPq/w2E+UXQCho/SZPETKnGaIxaI5lTLIfZOs/zQwH1TwFYJIjYMF8fg
        iaJnpVklg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpbW0-0008NJ-6L; Fri, 01 Feb 2019 16:18:04 +0000
Date:   Fri, 1 Feb 2019 08:18:03 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Heinz Mauelshagen <heinzm@redhat.com>
Cc:     John Dorminy <jdorminy@redhat.com>,
        Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
        Alasdair G Kergon <agk@redhat.com>
Subject: Re: [dm-devel] block: Fix a WRITE SAME BUG_ON
Message-ID: <20190201161803.GA21124@infradead.org>
References: <20190125021107.4595-1-zhangxiaoxu5@huawei.com>
 <CAMeeMh_=UVGwo-=9WtBXRmiHTXnLAswqis97bM-aiuwnzPU0QQ@mail.gmail.com>
 <20190128221441.GA24102@redhat.com>
 <yq1lg34f4i7.fsf@oracle.com>
 <CAMeeMh85T_qui=LWd0u=b_oMN5XLqowqkvLuYGBM2Ae6tS-mzg@mail.gmail.com>
 <20190131103924.GA22503@infradead.org>
 <CAMeeMh-uxiee7rKutnr3jrMjzkc8=R2Y3DPPBLvLYjqSwjfi_w@mail.gmail.com>
 <20190201073527.GA14758@infradead.org>
 <CAMeeMh-wAZ8377sMrnyQZUt2HT1hB02DHSROJURLmPsaZPkeQQ@mail.gmail.com>
 <f7b05928-316c-4c73-b04b-bba38ea60b27@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7b05928-316c-4c73-b04b-bba38ea60b27@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 01, 2019 at 05:03:40PM +0100, Heinz Mauelshagen wrote:
> On 2/1/19 3:09 PM, John Dorminy wrote:
> > I didn't know such a thing existed... does it work on any block
> > device? Where do I read more about this?
> 
> 
> Use sg_write_same(8) from package sg3_utils.
> 
> For instance 'sg_write_same --in=foobarfile --lba=0 --num=20000
> --xferlen=512 /dev/sdwhatever'
> 
> will read the pattern to write same from file 'foobarfile' with length
> explicitely set to 512 bytes
> (rather than derived from foobarfile's size) and write it 20000 times
> starting at LBA 0 to /dev/sdwhatever.

Yeah.  Note that this will only work on SCSI disks (and maybe ATA
for a very specific corner case).  But for actual devices and not
remappers the same is true of REQ_OP_WRITE_SAME.
