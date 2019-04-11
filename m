Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB281C10F13
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 16:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8929B2083E
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 16:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="J8qMadnT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfDKQZf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:25:35 -0400
Received: from sonic301-22.consmr.mail.gq1.yahoo.com ([98.137.64.148]:35860
        "EHLO sonic301-22.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726536AbfDKQZc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 12:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1554999931; bh=I9/9b8JzNUiEkC+ANGk8ni2bQCTQ2fH3InVBXrkHSjk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=J8qMadnTT6/WX10x774CADuqbZiUgg6SrHB+BTxEzi7/uZsXTI0mkRHfLbvMjQNOlLWR0tet/Y7tEqRZ6Q9a5bBcjHwyrEdkPCMDeKPf6TltTccR+lFuYdl0dLdQrnlV8Vg7skxVj0jMlf9OTpt39FNtVQnUJt7hhxR4xAnO3GaDkwbmXBpFFD/bsfJrvU/nZWrAmdyR95coxH/aJXGSS1+YeZTDLYKKx5u4Np+LVSLbaT+kHdh4wvTmSJ+CQD048Yp4uwUQBpbYypus/t7QDZ1uwwy+PT86t+XNOV5+bByhiMS7e2Io+vZrCZBNvY5NBZYPL6MBu1Jg3bI+3D9S3g==
X-YMail-OSG: KpcX.CwVM1n_5Zl1Q_TBEyil7KB_aXoJzta5M_NbNyGD8Rga7WlWL3LV_VI1ZPb
 c5a5ug2adA6d1YnXdasO_O8H.LZCp2P7WBTYLFE3QyIhr6l8Pe.cLnl1eTYYgXY6z9wNy75IIpMx
 Ryc5bK5hgVTnq4kNLIGh0ELfWW5rGP22zk9GRiA1CNrZHLk61k1qpkofeaMLaxMRUV1wO_Hw.hUa
 GLkUp83m4GWfQlRiGQ1_JTErmVDK6zr0A7D2oImiCsvkdJG5qsfL2k.XAd2apmVcn0bZvJ6Dq782
 qh00eEEu1mniHypnOQpgbiX6pnl9EfjsFGRNhbGjAYIHWixy3SbsOCsKHoQ38SXLrXlCc7TsnINM
 rS5iVF8U_fxIL5VWfVz2ZZRURhW2JqRbkIORS9xA6BQ5lcqaU0iUTm5NM5nBhfYsEMo5Sl7GTElL
 7BLkmIC7CEHf41GV0_ODRL0p7DM6wBhhLVpuHAYaMQ4zb1qR469Z3FVH5xTgpkYXXurmeL6xMWv_
 vFt8RRwnFkBB5rUZJ4RnufCLDO6oBLj0v.T6V9WtfpfxVv_vYTvXgn32RNfIo7ZD46NrgPoocDw3
 HYBOw4RERMxTzZzg2pLlMcWy4S01pXqWxAawyCBerkYBPx7IQ3NFKuU3Xoh5_qfVrBqIPVL.yOWp
 Vq0zjSBe8pM89R0KYRnddkrx7gnaeQrtP0cRwLVdDOCdxr7maKIS.lzMMsVQsFSAIjswsVOZsgt9
 YntLjYimLK3jyZyh0CZFJEfrDI.EILoC_EueHPP2arIdUqyqkOAajxomF_Z.3UdeVi6vO1FKDvbS
 gL43xJnJXQBvbvRVvsgRek8B3EcyKMfBWoX8cBIxQWWIfYw84MdUyGUM556oLAa7HXdNpLSo5m.x
 5Q5dI2IEn5Ps14vuD15G5o3y74rB9muQlsYIzNQxxQCUK5okAPtWOkNOM4byLnC7sErsexnfdCPl
 QnpjYYe3DEoMGqePOltxaVa4PYfBFk7sQMVXNtai8S8pKC15sUg4DLUNxHE0FOQ172dpuco9w7Le
 BHX_0s4GvqO9V9lZyQDlh9XPai4yFLDdyGhAHfcOP7oSet_leUjzBKmuHYbAu95wb6Y8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Thu, 11 Apr 2019 16:25:31 +0000
Received: from 183.134.187.219 (EHLO [10.1.1.220]) ([183.134.187.219])
          by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f05c167cc9395c75445739520518f23b;
          Thu, 11 Apr 2019 16:25:27 +0000 (UTC)
Subject: Re: Some new bio merging behaviors in __bio_try_merge_page
To:     Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
References: <85c5fa1a-a506-e26f-c354-1554d47d8b2b@huawei.com>
 <20190411070807.GA421@ming.t460p>
 <cb392476-a00e-09ce-fa6b-9e088242ecc6@huawei.com>
 <20190411080953.GE421@ming.t460p> <20190411153411.GA16987@infradead.org>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <9aa607da-6ccb-8166-22df-735a3b127f2e@aol.com>
Date:   Fri, 12 Apr 2019 00:25:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411153411.GA16987@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019/4/11 23:34, Christoph Hellwig wrote:
> On Thu, Apr 11, 2019 at 04:09:54PM +0800, Ming Lei wrote:
>> I don't think it is a good behaviour to use bio->bi_max_vecs to limit
>> max allowed page, you may see the idea from the naming simply...
>>
>> If there were other such drivers, we may fix it easily, and the following
>> patch should fix your issue:
> 
> Yep.  Consumers of the block layer really have no business at all
> looking at bi_vcnt.

Thanks for pointing out, Ming's solution is enough to solve erofs issue.

Thanks,
Gao XIang

> 
