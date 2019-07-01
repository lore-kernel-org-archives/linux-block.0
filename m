Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEAFC0650E
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 20:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF5B21479
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 20:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="CxPGgMtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfGAUAd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 16:00:33 -0400
Received: from mout.web.de ([217.72.192.78]:57721 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfGAUAd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Jul 2019 16:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562011222;
        bh=2bnSCawYQdV0o3KcPJNQgz6BMW1THte849uoCeTmLQs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CxPGgMtIachIVM7iGg5xD4+pPaFh4MIvptNnRyno/Ku0YYAAN/3oRxJt7cPgEUTwz
         U684xK8JbNQmbk9QKGxxWa6S7kMRBpmWpB9g6ZUnSM78Xhsl8jT6vOsOuo5ZWiSEEE
         vt57R/yYERZtExW2HNxPdVa4QWN2miQOfVTMw2c4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.131.202]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0McnuP-1hzqRL2LSr-00Hwau; Mon, 01
 Jul 2019 22:00:22 +0200
Subject: Re: blk-mq: Use seq_puts() in __blk_mq_debugfs_rq_show()
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <81847ca5-fac5-710c-29d5-f70b58f6437d@web.de>
 <e2a06dfd-4a03-2f56-59e6-abce261653d6@acm.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5a8b6e93-72fb-1900-3338-662db7b8975d@web.de>
Date:   Mon, 1 Jul 2019 22:00:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <e2a06dfd-4a03-2f56-59e6-abce261653d6@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P25t0z/Xk7+yzRy5cfQInHyyLeeaFHT2sfFQy6OftBeiipO/4AQ
 teysYV2y8H5+tY/IhmLd9X4RC+EgSRfHuBjI9wcOHHQlNQgMRGluDfJryIRYG+dSoyJHJbR
 YYzK2Gz7JBC3GuSelEtm8cKnwTCOT1A3VHgoPiOH1IggjNDl12cxMOr6pkYra32yt+g3wXz
 x5Y++d9tF+YRYITrwMEmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8j9uzHAvOyM=:bZxzg39kDDb+8cuHzF5JeZ
 Gn7flCIhIIRYNeysK+qbKs24iQ2UEdtg1LOZRbxMZtlKjYOSqrbL40JP+deJJwI3PGMzZCShd
 5Y2Ou4cfLeWwWoBs6ccqHFtM5/OWBo+Zqi6slZjSz8ynfo+GprvYgcp417gbOIw+eGbkHDtHi
 4lzSDKhlEOFZkI7EeFIJmG/revfLhUIJiWikuH4OTSNyPK6Vkk3/PL/6GmLQLbtRWWb1APSB7
 hIFqtaxyVnUpuhfYqw7WmZWTaoFvjM8bdnt6JfCAhNs8Sb281toemSWbOE01Ct8YZ8h4RCMyH
 bo4/KVF0nAH7+2UDLqtEA6ge2opnINDjwIK/vCgBsiL0Wy463ujB5ZOyVGHxYOQMJvh+Hw9kV
 4PGjRL4s32INDOaE8UC72DXDQL7g8JAcko5Yj2PtpWBi4usAdWN7Np5CemzY1fI6FnmykiZaU
 CX5mjtHvxRr7nchxfMvsF5c/n1SAuEccPViarviuUar0G6gNBqimmLkBl7vWtTC7Ow3PMRen9
 ipMHH0Q/1Gg+bAQz2I41AnOAVoBLS/uYoOq5Y9SKuSghLNzmLrsTXT8Ks5Z57yEjWt7O/SOSZ
 AFBqOW5HsTjoo9rqAn8caliCYUvGl+j67Lk7u7VWXis/rVpzty23rMN7DPJVmYVhVDKfb2otc
 PhA6VCTnwflCi4u3A+FMBkzJNYyM/QYKa5RWoE7/2lDMwQqujqu/oP8c2fou1UzTrqwJ0HoLb
 PwI8j/8csbhhQ+Tc8nctlODI4SzY6d/NUNFmKdns+IgCBRGOzBWpSmEborHfsKmarRYoT7XUE
 kFgjMq0sgvDuYduqxwlo1RKOCmsVMv1TCbcLfSy4U/bXtERnpdOsr0aXYCh1TLbWpCNlpy+29
 tNjCQqqG/2kOzZ55Gqc54UIR0lIWpzNtcDrLazG+uNN8uppV59040lh2gLr+kew5OSOSlZ7KL
 Wpq1bh6BUX3ZKeiE6dw+u8+j1Bqo6/DCxLYFXTNOcbOh2o7u+pQgmQUyanhXyRdQ3eBkkdPe8
 TJwPO0Fah0KIfhaCY0WbrxvKfXP2OJHDtxG2oZ0QfzLCK0pXJ6hI28iB9ikjoimX+TwTmEj9a
 DfewLiEE2/KT4RfpSUxaBfzGGLD1KqqpFED
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>> A string which did not contain a data format specification should be pu=
t
>> into a sequence. Thus use the corresponding function =E2=80=9Cseq_puts=
=E2=80=9D.
>
> Why should this be done?

Do you prefer an other wording for the desired data output?


> Or in other words, what is wrong with the current code
> other than that it is slightly verbose and slightly slower than seq_puts=
()?

I suggest to improve such implementation details also at this place.

Regards,
Markus
