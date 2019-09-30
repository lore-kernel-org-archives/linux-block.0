Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B1CC4360C
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 07:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B5221855
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 07:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="gpQp/i7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbfI3HQi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 03:16:38 -0400
Received: from mout.web.de ([212.227.17.11]:36777 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729232AbfI3HQi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 03:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569827791;
        bh=gbMOVn8Fn770a2SHIGdp8mDBqRMkfvq1IBv/5EGkKTw=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=gpQp/i7JtZhG2At0h3YidtTwMYUP3sKmfBpCCIvpnL6M8Obx4KsNfbMiP7IcaV0wZ
         0KS74MERJU79ZZpsn5fueTBeLGvudk9o7fXbf9d38h5Cm0D5E7eYXslAybtn1XPLfb
         Y+QGonh9m2TW4yddSl9wJ6s+CjmcaGduTT3ol9AE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.97.105]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MPYB3-1iAB5i2BCD-004mVD; Mon, 30
 Sep 2019 09:16:31 +0200
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Matias Bjorling <mb@lightnvm.io>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190930023415.24171-1-navid.emamdoost@gmail.com>
Subject: Re: [PATCH] lightnvm: prevent memory leak in nvm_bb_chunk_sense
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-block@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d44a6dca-006e-5bcc-64b4-2b62cf9a9769@web.de>
Date:   Mon, 30 Sep 2019 09:16:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190930023415.24171-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/BiU2QFsDIz7Z6Efh886OtMBZ/zWPmQ1Lm4VSlF3Em0WcRxdrGv
 AHGP7N3VkVcCV7RkHksWdrJLVy3Y7g3z+cnZpCwZybt/XWpvf9tmASR1ndDIFifwMeVgu3K
 9sFB+1uV5t1qvok61HCZO8adqu02UR/AqsORjw7RTR7EnILVKqLcfKpApi2MSr7um73PJCq
 1/JGMCkBBl7YUdED2pmOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FnKkHmUXkZU=:nDkQm5BUAKEvNB7iq/Q74L
 +7YYKPEoZsuTRBt4aWO5gJXrs6S0uzs5wRasg32AbndC7pqvSO3FlC8xPCwokHiEeg+HvJHxE
 3WTnrUjOGfr4UzgI/E6rlfAAjSH8vQIB8g9O9kKoQwQvPBc8SY9LsWI5Jx8ZNUP1CC/70SvNB
 /83BYGmdBZNiIDLJxSt0fMCsWsrGhgBYXX0V+0IGS51lfs2J4sBKMinWTrbFI95C3TyOVycij
 UlxvyEgykpMf6qdXeS9Oh0KdFvVMeKOry0n9tzLrxj9gX0MEZHwJLG1QQAf1j8Kf+TPgcHeIc
 yd7A1+G+e5PrEVG7zldpGNAIn5A1EY/ZShgRlmGXwFJIFz+0IRjKV31BouqwUoiKzchmDT7kQ
 UA4zmC/e8LABRfrGolg4Y13xKyni9AwRxv2GwJf4n/r1IVyltQBET46uV2Yuk/I9jxaaFTpYG
 BXeThpLcH77XJjeIQUlfMZWN23rnxhaCBfmM1KNVfITek6TUo1sIVyniwKXXSr+YoN7f1tZxp
 CsbNRFFavRtfvIS8KoqugwNupOVJVJjEsG9DwkeK7ljvAt4oMuNwHMr1UvVsNvZ9i2av0b8Ey
 ujrILQCJDejS0rryxxvM9nFCfErQR5QRILfpvUMhv03W3axjREsj/6Hj+g6VmEcwDy7vVdE/v
 +rJOjLNm8RTH5hbrDZ0A+Fwryt/ZufsbLmhy+ZXInppZKj1rwbFqg9J0krfM9ECrKtvfikikj
 bL/1UA1ROkHdn+ikHbSgFuWAfjHgIB7B+OlJWFZS4WsuwQAM6psbTbbugO/2C8uFkZatt1LEC
 26GxZaJJhhnLttNDInX8B0zWYc1p3CkbGiN6cnMYZBAnCdBmKKZgGIZrffSBM/GW9Ml+W4pBB
 POdE9b/El/gtaSbT7sUlDsNQARpNGdVuENu9gz33WR++XzzMdIIC9m3yiD4Zz3eL61gp6citv
 B63nOxNC5r7jjp/V2ByrAXZ2eJnRXjLUnzJUXFdQF/+edhSOK2Wmfp9vgTF7jH2uEnDhO3Mpo
 aPoeqD/P3lN4gd9yNBDTF9Gp2JQ7UkAaKC9+Nj0nFbrksbfAytg5USvx98stZU7fkRAS79syc
 ygz4G+JivRlWYxlzuws/16AEHkVXoHCMpzTVYrGsPpMZHdRPkcrYOUf2c3rCLKacMNRTvQeNk
 79+IdVQmop0z+bhaTz+GKjWfG28x7YOLIPIt8lwSfQozbePWOcbXLigFdXmXtT71IefwiwAH+
 cXeQvnFXv9B7tUXTiaaAZ/Yy/vY8gKPZYqSKvL7jV27O/CgNOjejpBNyFdIw=
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> To fix this issue I moved the __free_page call before error check.

Would the wording =E2=80=9CMove the __free_page() call before the error ch=
eck.=E2=80=9D
be more succinct for the change description?

Can the following code variant be applied at the end of this function?

 	return ret ? ret : rqd.error;

Regards,
Markus
