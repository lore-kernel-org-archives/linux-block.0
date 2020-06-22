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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F260C433E0
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 14:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0900720720
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 14:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="eT9uZDSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgFVOZ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:25:26 -0400
Received: from mout.web.de ([212.227.15.3]:37645 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728070AbgFVOZZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jun 2020 10:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592835906;
        bh=V6Q8cBw0kD+G8q0pAFcgv37tpUIlHMiZPA+A4MhrdPo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eT9uZDSvNqbakW4ChDtZ7u72WbEMR6zFw5agCL8+OPyTebkf68BbjSByQ9kS9Y87k
         5evrD/ye+SgzLvCzSJvaFPYOVUf0wh0BHy+5uC0Eo64rA4CXSBjTXGTOt18hnAhPdl
         q1aE/SK8UhFRttSDtB253b/2hWdoKbwcPDpvABOs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.69.81]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MZRnx-1jZPGm3JbZ-00LF6W; Mon, 22
 Jun 2020 16:25:05 +0200
Subject: Re: [PATCH v3] nbd: Fix memory leak in nbd_add_socket
To:     Zheng Bin <zhengbin13@huawei.com>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-block@vger.kernel.org
Cc:     nbd@other.debian.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <mccamant@cs.umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
        Yi Zhang <yi.zhang@huawei.com>
References: <20200622112001.105047-1-zhengbin13@huawei.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d53f66d0-a122-017c-3f4a-3947adc13fd8@web.de>
Date:   Mon, 22 Jun 2020 16:25:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622112001.105047-1-zhengbin13@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2z7mcXh+UhN6k3jmN26LXJ8uncApGUz8XdS0Kx8R57YEwpzxd9O
 JV97tTTW+UbIOje7gEMZZstk1m+Jidz+JkZ7N6hUqbPqjFs1EK91Jnwtj7kkYT17JsBpADJ
 1DtVOSJda+0mqU8gL0BgJr6nD/r9thJa7UAiGV9ZXdZ92pLMsvJhI3wHyr+y9RriebHBxe3
 u6fOGOZDBFcBWfYMCNFZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zgo/q7948fA=:DhS7GxkEXqgrgQtm55L38x
 U+6RpbTbi6HjGxKt9YbFuAZOB87lptA+b4dUbZ3h8oEV31n1Xisk063asTYS992dRK9UJF19r
 wpOnDe8ZPdGMVi/DR0NZ7kfvM//bQFmsMcjMYLmSh3qqB2M8CZyn7hMuSpBYrPOI0bzF2vNNa
 n1u3JC2B5eFmYdMIPKO3Cgx3iAKknegHWUKdV0Ke4pvBKwsjB1xSNjGbVwls6iQa4uIM8A42x
 J4BFrR2ck1u6E2zde4+CH0jQkXnKy979wjdyvO7dZQ4I0Q2tHxQwHO1zIMBvzPiSomnoDax/U
 Vt+vnk7fqGStNHz27XjFF59q3EoZ9UGVJPLzsqRTRH4erLgECPsObTd2VRAJpqBULyEguB/9Z
 sAL2zF7AsP3MmYbvOb/6LSXZM6EvHFFxBIpd6vDNikJOjKyA/M5+HCgHB2bDf3W/koeQFepCq
 BxzSwjSRZxMmKC8ik5FQM8Rr0Q1acAtieSH/NIiUbcdxs+lp1hnaI5vM7AvrbE4negBUcu6mF
 RvQIlmU63umUA2dPtXAQDNbl/DJYYkCKEug/KWlUqV56DVNZtKpwzoMo+lWdkFCU3bCdP2YaQ
 CF0bCpjA5PHqaLnQCZWFxtwPYlumD6I/aea6N0a5Bv8anRsvwWzrPZYuXLTl11tpl3JelFy6N
 bRTRZcxoGopaaJTHyA1K7Mq8wz30jvYG4Bv++FvcTgsbDAqI+pNeIvK0qfWzAFBubDquS9buk
 p61aHDE5H6tzDcUxhaj813vBwP871GxIisqnLJ4hvSLVxvh1WYyubfqzAD9DEQ8rWO98993T/
 8Imtz0bS4qtn1+eJ/h1sytNoGywZFQND5kcumA3idM4d94u8ETEG5oJVJc9uJbvQQlQJgTRzH
 L2SqZUZtUwcVqymGnqi/daHFgH55Fuh9RDNATLoZsoab+RhMSigquHtL9rwS+zMYtWocwGNVw
 gsG9GWLp5HVOkPoW6JZJrtV3Irkl/n7tIYYMNFnUqpKJl91/PoSbhpE+TxfBcWmMMfWZ/vy96
 S4zC1WrTOdShvozX1hj/R6EEzwNseG0TEaNNRGdX7/Gn/cZx/+hHeVxY/dNVd2q9HnGWG4S5F
 bQsrgNEm6cHRENxdEYdK71iNkQyDhn3rYYjnrcz83SBMR7WLSxrMAVlbbSWFF5AEle+q0AQ8L
 0P9m3SKYxzducGH913EVp7tPivQWXKnK1gEbmlXzz6FdVC2yxIzLF6rZeDaPV8G1Kb/dM5Yzs
 7Se9q6A7+9oAnBrZX
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> When adding first socket to nbd, =E2=80=A8=E2=80=A8=E2=80=A6

Can the term =E2=80=9Cnetwork block device=E2=80=9D matter for this change=
 description?


> =E2=80=A6 A memory leak will occur
> then because the function "nbd_config_put" will free "config->socks" onl=
y
> when "config->num_connections" is not zero.

Will an additional imperative wording be helpful for the commit message?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D625d3449788f85569096780592=
549d0340e9c0c7#n151

Regards,
Markus


=E2=80=A6
> +++ b/drivers/block/nbd.c
> @@ -1033,25 +1033,26 @@ static int nbd_add_socket(struct nbd_device *nbd=
, unsigned long arg,
=E2=80=A6
> +	if (!nsock) {
> +		err =3D -ENOMEM;
> +		goto put_socket;
>  	}
=E2=80=A6
>  	return 0;
> +

I find that the exception handling can be improved a bit more
by adding another jump target.

+e_nomem:
+	err =3D -ENOMEM;


> +put_socket:
> +	sockfd_put(sock);
> +	return err;
>  }

Would you like to apply any further fine-tuning?

Regards,
Markus
