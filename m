Return-Path: <SRS0=vyV1=AD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081B6C433E0
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 07:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC71C2547F
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 07:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Amvoa3Ll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbgFVHxQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:53:16 -0400
Received: from mout.web.de ([212.227.15.14]:35621 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731310AbgFVHxO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jun 2020 03:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592812345;
        bh=ZVSR5nyORNSx7+DWEx3pNcTs5a4pea2PQFI9qDf1fXs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Amvoa3Ll/JqLso9GQr3USpZ0NIZwOM2S/kRwkCbwvqIb61JXY1pEXJpM/BttegjU6
         /S17XUvq1nGY6eceIuZtDb6hr4Vah4SOh7uQtDnsdw91RwPnWonLG2dtISgWQzKq9r
         pH9XG1hilFliEkpNz7Fc5nxWFzrl440kUZ50Rg8g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.69.81]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lilcj-1jHnuu1zVV-00cyRO; Mon, 22
 Jun 2020 09:52:25 +0200
Subject: Re: [PATCH v2] nbd: Fix memory leak in nbd_add_socket
To:     Zheng Bin <zhengbin13@huawei.com>, linux-block@vger.kernel.org
Cc:     nbd@other.debian.org, Aditya Pakki <pakki001@umn.edu>,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <mccamant@cs.umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
        Yi Zhang <yi.zhang@huawei.com>
References: <b55f8af2-b20c-214f-90f0-9b6efcb7273c@web.de>
 <db17d022-a53a-3781-63d4-c38d5cf5b1e4@huawei.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1a58ab81-3810-0763-7394-10b51add23ee@web.de>
Date:   Mon, 22 Jun 2020 09:52:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <db17d022-a53a-3781-63d4-c38d5cf5b1e4@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hCxjAKDqPmcYUqH74KGkP4kXff/2+FeIXCQvsDkz3oLMHfep4CW
 uFl8gaY4X8sqHgOooegig/rCLs6wkWyQuKFbRCmjNETGto6fQHx6V2UVmZNVlL+h4fpmrgC
 H2FrV80KSQStVdKN50Y3xwsoHnRbmWLbvcHF1JJGqSJCrLNo+72dYyVIcpIJg1nRYQ71csa
 G+0CjyKbzRKQbNYe2ZMAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z46aFjNL7eQ=:XsG6hxPZcZsv6a2vZdYROG
 hu0TAVl2kVzXqqMpuis3so0qCtJUfc3HES4MbTMTw8IJtQd51lVDjmUIPqEmlZXeeLESf5Y8D
 037LDQUVSHz99i80/9fggs0cy0dDTzzhAH6JidMvENIzhe1RiEC1/+uinNt2UUls6B1BSlEbV
 xKr0usuBxZhKlz6qt8S9ujm+jv6zbGntvaz1bXJNYDWSDaRy1RcilmvfqDCBg88JKa5fquoxd
 VdKBZL8VV7jdX5Fekd9X8HCeWqwF1HJ5GPEQdg06l9rSNCEmFU8aL7pgE23SH5a5KFdItJs11
 E/7c8+HdwZVd+nCl9Ugp7NbMHUqiIbeGvfnd45al4kFFLK2wzJjWFMfaDoSaBVsmDGAu8c+1a
 24JYX3reMh54Y+8KwKLawbKzjXukZi03yl0yq1hQj4z1amhTjEoEAxbi1K8jKDfuQGidkITxE
 QM092GnYAvWS0C/0YhxmoUAg+k/8V6dxybhoSphWpXWbjNqDWaLAEKgB7KHNGs3fbURPTQy27
 KZ50XWGScSGGAqQVQLqHwI8CWteOdfV49Sew+2R1jAliDadAn2ve9dhR8ZK3lZA1kZDKypezr
 EVcXG04jlterazZj1JW2Ae9iztwVty2faEFc/WXhTCNH1oDUzEbwaUud+aFHulvI81oB4nBRk
 5bOH/QWzHkcKSR3UQSszk0t2C53AhZMrY+s9lIeV28lQlfzV0RsSys0bPUdR+RMWXhymDOtex
 SMqMBG9C/vTZDpzvKjyJIi93b70TDsDfSoGOehezkXEbeSGMW7aQu2iDNSQOldTNyMmXrWgnY
 mA71LhHBu001ObkXA08/N/Hsvi7Wzgxdtc9+ro0WoInL8iNvFV5qDC4qLVPjKQoJWXRlU5Lyw
 mJd3B+4Rp5BpJHimf/G9y/U6k29QOssVWPkiB5bT3guyh0jtEH8j9FsnnjDV1q4lo1RTu7j8s
 WncMoRYB7OfMWMi84TBJ9k5rzfOHlvesPHRL7uvvXvEmJLxkEa9j8wHyxmC8FheAvGv4ClJtr
 Fy71/eBIQ+Ku4CRRjXrhOwSGn4FyJDM5a3bvFHwCsW66E2ctAfN7BENa4K7Bf5YQ+pEsr1lqu
 5t2A2t0seVauH5YQd+n911dJbIGAtyDgC4p9PNiElZziN7+FFtkXmfU0YKJGKyWoyjKlGTYRS
 ybP5B8E5LPVzIma9JWCk8dnseNqshDB6AlbvMw6nAyXCDxOzM4TaTDdCoVyV9xULoXACN4l/I
 SYmcCDxEePkHjoF1O
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>> Can an other wording variant be nicer?
>
> em, how about this?
>
>
> When adding first socket to nbd,

How do you think about to replace abbreviations by terms?


> if nsock's allocation fails,

=E2=80=A6 failed,


> config->socks is malloced

The data structure member =E2=80=9Cconfig->socks=E2=80=9D was reallocated.


> but num_connections does not update,

But the data structure member =E2=80=9Cconfig->num_connections=E2=80=9D wa=
s not updated.


> memory leak will occur(Function
> nbd_config_put will only free config->socks when num_connections is not =
0).

A memory leak will occur then because the function =E2=80=9Cnbd_config_put=
=E2=80=9D
will free =E2=80=9Cconfig->socks=E2=80=9D only when =E2=80=9Cnum_connectio=
ns=E2=80=9D is not zero.

Would you like to add an imperative wording to the commit message?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D625d3449788f85569096780592=
549d0340e9c0c7#n151

Regards,
Markus
