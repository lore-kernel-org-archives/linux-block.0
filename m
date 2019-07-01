Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477B8C0650E
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 19:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA9D206A3
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 19:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Rb8D3/N7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfGAT13 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 15:27:29 -0400
Received: from mout.web.de ([217.72.192.78]:51621 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbfGAT13 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Jul 2019 15:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562009247;
        bh=GWwxUQE6FB8EWsuvc9HJ6mh2TC59p3Jmek8dsULZxE0=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=Rb8D3/N7G0Xbj2CPue4SYY0HVdWJQf3q5SybSD88Dt9bt4K8fm6H9QAL0gxzU89+B
         6gC0y9XBOcfcBPKv7vUlEMTPFtDU5T88tuG/hCxbOoNsIYkCZxKJMJtrZZUKEGGr6S
         CMT+6JFowQdG9WBfGay8KRUxPw4nixm03sUIALSc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.131.202]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0McWrM-1hzYqM3BLM-00HdCh; Mon, 01
 Jul 2019 21:27:26 +0200
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] blk-mq: Use seq_puts() in __blk_mq_debugfs_rq_show()
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <81847ca5-fac5-710c-29d5-f70b58f6437d@web.de>
Date:   Mon, 1 Jul 2019 21:27:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wlza1isAN/pb/H3NYTUflOg+pWErlik1wDkEzWUo4bwYu+39I1z
 LADfWqzcjq+Hj3kOhPh0kyqs6rA42ww6H6og4/FGqBnxkjX1D8WszpPkxeB2QTCzLEG4WqP
 koP2aMF091OD1EdTihk7LzybQinDN+OjABnFoKzePp5oMUBYabTbvjjMJTTqOW7PmwqSHvZ
 gEFuUtu61WeyQQW+ufn1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LVmnO8g8VH0=:TtfGAsG5a9EW/SJ6bq20ZZ
 0c4StweZpwDV6F4zXvABkiNRdFJibyhDXCSvb/Ktds46lVIOOpJUt1HACDQjdjOgNOQ+wi5mE
 X+Oj+nt9wap9vwhy3Q+UqJ+wZsbFsDmMc21b/teJtEzKtzmgUKkO9+AoTZile4Z/9EtbsYOgo
 YDt45f3V+O/BGPyGq3e1FqF0elZHTVV98JjrVb6d7BUvWRcauBzQnzXWtCH7S/PmXwMkyqvd0
 qRmtmU+smJNX37lp1ayckE4drQPEAmrmd9Wh47MVHzjMQmW8XQgH4RqZ+FZLfMTJ+hE6+bb9O
 k7p6KWsx0R1exxUNWeCrsehTlJUwZcV9XZoUB7ChUXLYZ4OcscW4q8AQ01+ice854BmDKD+pU
 ntvEQiwxdz+ayCuOKAHEBBgWTXNiLJn5+WLrXQRkd9FwZolpPNQ3VinoEsO9aKw5SocY7NvJp
 vxduVV6st8zfGAEwP1B924ht/5bjhoHVTDUQXfwxPxrDSEU4j9TYTZlBnUIDvXqKVPv+JVSko
 aJ/kNneZ9fBE+1av5BbdMft+TFhUFGelffLk7gnQF3pboNFkzn+u5z+9OMXBKJT26COp28PgP
 FmhqIF+4cnxCj4o/0wwTUzUxTx8CsA3ACiy6LkzaFotmwVPez8bQdW8CBXFwIAHHSsQ4ERoUA
 7Y9gUfhUX33FSccTqrlKtMu0+nhBZXQWqY6k2rmC81tWOFz/dlGvuSGFoWmfkMcgsLaxVNU8C
 bcgY0dIIhMBTTvfcfDV+lHjuD1Yqd9e6tFd80HInxtelFf2n53YI1jzZ+xC1Fkqx7q9UIiqWm
 1Atc9zxAa0nv2A6FgcfImEGwi0tmnGziIxM/+ppopMlncj8HKQnKyfkp4fodulQbTLng5cv+5
 BqeSeh05b75YF2IwF84uJYkqU8L4CmksmA/KIbQUSAzqNcT8+e+3ePxAMqFvsa7qyie5LS5WS
 dOTb18h1Hzftm8VDZ/SRcFmdYm4KysN0esOJwHseEvyPMfNKFEUy/C2q6RYdPRPQMzI5LkLT1
 Xt3f7U4X1bqeCTpP8Pn+I8df2WlhlUjYDny8a7e2aB35AUot+dp9/zc7YufHAaoBWw2L4L6sX
 DkEW3GfPJHMaZZ9fWx3B0kJjHtUpnKCU66i
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 1 Jul 2019 21:21:04 +0200

A string which did not contain a data format specification should be put
into a sequence. Thus use the corresponding function =E2=80=9Cseq_puts=E2=
=80=9D.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 block/blk-mq-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 748164f4e8b1..bc1b70aeb2ca 100644
=2D-- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -331,7 +331,7 @@ int __blk_mq_debugfs_rq_show(struct seq_file *m, struc=
t request *rq)
 	if (strcmp(op_str, "UNKNOWN") =3D=3D 0)
 		seq_printf(m, "%u", op);
 	else
-		seq_printf(m, "%s", op_str);
+		seq_puts(m, op_str);
 	seq_puts(m, ", .cmd_flags=3D");
 	blk_flags_show(m, rq->cmd_flags & ~REQ_OP_MASK, cmd_flag_name,
 		       ARRAY_SIZE(cmd_flag_name));
=2D-
2.22.0

