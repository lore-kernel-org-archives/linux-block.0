Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39799C4332D
	for <linux-block@archiver.kernel.org>; Tue,  2 Mar 2021 23:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C2764F55
	for <linux-block@archiver.kernel.org>; Tue,  2 Mar 2021 23:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhCBXrq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Mar 2021 18:47:46 -0500
Received: from sonic308-55.consmr.mail.gq1.yahoo.com ([98.137.68.31]:46138
        "EHLO sonic308-55.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1838041AbhCBWO7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Mar 2021 17:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1614723223; bh=IoJyUk4Nbh+2Yi6LTvulv/umucSKxOqnBZJ9GCPOcw0=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=mXmmAAXWDd5KucDFiZfAUgJisY7bNyIius9akQPBlsZwy1SIN47u7bi0Ny00fi8feqKioQ5r6pim8uxkF2d/3JSfmwgb4JOUY8vCqZGw1C3GIQ3X4f61YhxZICuUF3dSUyYOJXYlIqnJRU8a0MZOoJCF6RnXPkHM8ydIkVlKW6qE+4QwRq4fxp+/UVXdRvLyWblm9HVYP5bmY3NGJXaXUoDhsNFb/OSPEFTYWjR0VvBscthitk3PFf2fcRqwzWdguBsKCCbtZm2GOTUJ5t+CfIvc4Ul/YEZ1uQLeWmlzklS16E48KZFRAtRRXwR9I0Pps0kESvxqsTwdaNHzV/GZGA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614723223; bh=nSnUWLqFKDj7l9bM1P39OX0x1yrMMRmmaL3EhCjtJCx=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=rOYTDKaXbjAv4DTWQ7Xtp37OxaOtsXeuLmCgTQRmFIbUvhUurioNr4X5P4ZanOj4+IWNLQg7/azXXFvyOp1D37JAnvj1/SaMRbYRs5nLIvRlZQ4ecSsVsZDzY6HG4dLle+p+5kgJWeGF3DweTTJUhewQJ+KCco7fRNQNzKLRvKUTsWrcN5tMDRARzFOaDtRjRUJ7xoEyXbi8DGeYAtLpMuamDDBXcR03eiKjdHA+PXqlrowJ+3P7L+ydm4AUC+sZ8rYpwwbaFS0P7QmxymFWLonp2QsFJGNjWUAo7bQB9vcVNQQ2D9n16Jo/RNbHG8lSbq+ggQU3suzSurm3CT8T/w==
X-YMail-OSG: kiwJ1NIVM1nIwCu0XcoAuO0BzwhSgO437LZSUF7P.no3b2g6XUtdD8dOwiY8wkB
 NxZ6k1U0c5s6nQAZNHnsQDujVap0Ji90jOxdhqDGB5g9A12.c6b32XE9kFmcsGORB9U7xP1CnqHY
 _57WTOMUY7jpnCZ2MCz8A4gh9CIqpE.8xMOr7cGtuJ_Jmt1qZvoEfc7MdKDAFBfdg3kNpDXIb3o9
 13st_.3h.oqeFo7ePsUodU6j1OtdSEu8xkS6Xg4fJtlfOiHRk.4pMRXBZ7vaeKZHw4R60zhLiz9J
 K495DAaTeUEfI183oOFXAPf.wBybp9rBH1nw5pIqVT8fJ160Un2b63IeVzQsb.RbXg0Kij2u7Kxa
 _nU8grCaoBjtIWjzKJM2PJ5hqKmVfn14TAbTQOwSro6pomLlGZSAEYdDSt5v_porEk4Q7kuIgEtQ
 Z9Nrzs34EO0kTi4BGSulr53ahzuAB_9NAGBgn1q8u1_TsgRQMbDbO1x5LCmHhdPzTNKYYf.vr4V6
 FnXCJPYRJrg85SB1O0874MvguA73OoZqdfTfh4.KZb.IFGjdjJMCbtUaHWpm9yNsPCBzRuFqeBHQ
 YtJsPU6lo1hTRPHffH_kaP65Fqc34e5d310ejnd6.eej6SMpzeMy2mTy4uZvoTkGKtIVeBr1vKUI
 iXP2UYdjEKG6uR.pZbNT.xydPcl57LBudbw644Negp94MgKTgTd7uMG7e0wNYQdgIWd.0wPFMgMr
 g40.d_XX4jizXZP6p7kkg.uHoFP2NM7zLYi5k9EUbpQy_o0BHgPTy5ertlcDF9SrwMUCEYX.4WDc
 ua_ql6MFz8Hfe3ybOQtoiGrO9l10egzYcfhD_Os.7SnLMlPVL2LjHbidCqz6nU6Ker.q9PRYv8Io
 WLFvsTOIDN9MAV_nMv90AhOWZwsrVlAm.wwpSCBlK_1oZRBLQCGT1zitl_XRea1cjtPXhisJO10j
 fZ3iBSDTii.WbO3ac5N7nYL7m6H9LWztP4kPcKIPhs8Z9yKQO6hL5U_wuC2zcP2wNpOIsq5B4Dro
 s4ye39T0qSH1ObNHHhXrkCE4f7AVKkFxzHETKudBG3fmqc7s52xJM98byyoWaTjdbEU8Vp84rVn0
 NQQmy_XIFa0KDBzL4PyRdjxO6ckMXLgR3Zsu8bolLZH_ChG84Iaw1_O41MPdu8qAyqRYKr0mw7hN
 OiPyvJOA5V0gWocwX7q6M8rWc0SHFa6tXPMyWPjTl0VkHukO3viopv5IFfkLaLkK4wzUrk3DcBYy
 fGmm_ZSc5xuMsJBcwKLcwotujMQOyLWtZtF1WsdhtkgQzS3AnkM2XAwPbdIeZDvlWlDccNQwErMN
 an_XK3HKn7Ia01jxA39j.JwwmuPuCc99qEQcyPfKScNV.FdxSvs3V.TcOmwJMMsJt55rVrEEI98s
 cvPAmfYogjxTLuCiOR7zrVy7Pofpkh6W3SmBVXmaqUDQaM0KWrlSExDJakmLEeqCaPGGT9MlqAnL
 OYqWeptnwlOcZMl8Y1A7d4f9OgHbUiLH7DMPmeXmQ7WD4WOAD2Cru1d7hqjaP4gHrtebPDemqkoM
 Re41hosA_swxRfYOf3TJiItadXgMySMw5e8eSF62ZIoo5gJTV3gHLpJLRPlOapaLZoiHf4H71ohU
 gVWAqBarrYM8hJP1brvfFAg30FqeNeiU0TAW5x5yukfAlL.zF2jCRhVTOW_FxXvUxafMbd5iEVEC
 6I3roJt74TXTt8Y60Yere.Lv_Tbk1MiOrMWiYRMa_KX5XQ2ajOVrGYvuIOGp.JUYsN0DgvfaNRtV
 mrVLxWDa5UExj5nFfcZI5_.1.2BNgRRtHsam9CdOlb.yIuJiP4g4rGPCXtRli3_Xa.Yvp0UEPKSa
 .wxZ8TuNvU3hDkuWRdeP_wCb_Xdy1Ivi6jRSNz3PBc4Ww.JO3zFgXDXYtMoKCtWkE6zuZP4yhkqA
 M_XrzDOyOfEo6m.LNgsIqNNEAKfyhxVMmadMdmtLGbp2J1O7TUS3MvDbXJAz.GcxM9CVi_vT0qcI
 uM0nI9FstEyo4JfrW5fjKmIkt0i1yUCv8DyOE0ofawmNdQ5CpLbGEkD_OUT_LHcvktRdlBeAs67E
 dLjOgX7GZZIpqbBwTu1.Mkt0qLXIDzpECapinf4zqqep_UQrnt3eqvnpyeknK4ab0PNFQhpdq1QU
 hYAhMXdozJXp.jEA6L18QY8AjBg90zDV5.6u8tEzmDMornWBvmjDbcvlr6HzItNPqlnuAqT7K28B
 .LOzf3Qnb.FB50gEfww510IWFwvwjg8WvWphGwyAeIk3_9RPGbwdNhQrfhLOE4bC4kXXBiwD4Qzr
 rQ4fwn.pubC59fYxm95i3zqhInCqfkNS.zGPJ8eDMmcMWw.G5EliVKhS2CNTC.S6oc1pTY2PoLYg
 MejlGUFHaJN.2dqaH8mZ0CwI3C9mQ1FNXv9QNQF8xIE3117sxFU1613c2TCOLuW3HxGEsLlH6d5F
 DL8GzSbpDNUYSWuEN.E38YOGnfoZCzzgSnCHGYOw8SlbT.fvoMzHmfi.5wX0uq7awXWygfaUnh9v
 mWJETy6dMmIpDgX_ZAM6rT_o1souRHP2UtWDrWrbbKBak7z5mLvwBTIchH.cj7PPoBmL.cPJHEDo
 -
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Tue, 2 Mar 2021 22:13:43 +0000
Received: by smtp404.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 4d896f5c720e3fb92b3aad8e7a720f1c;
          Tue, 02 Mar 2021 22:13:39 +0000 (UTC)
Date:   Tue, 02 Mar 2021 17:13:35 -0500
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: 5.12-rc1 regression: freezing iou-mgr/wrk failed
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1614646241.av51lk2de4.none.ref@localhost>
        <1614646241.av51lk2de4.none@localhost>
        <ad672889-2757-142b-9259-3e0aee6d8078@kernel.dk>
        <fd148797-d8cb-7597-8612-83ddfafac425@kernel.dk>
        <8cd026a0-ada6-9ae5-9ea1-a685b482173c@kernel.dk>
In-Reply-To: <8cd026a0-ada6-9ae5-9ea1-a685b482173c@kernel.dk>
MIME-Version: 1.0
Message-Id: <1614722744.btwkumq4s4.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.17828 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I tried 29be7fc03d ("io_uring: ensure that threads freeze on suspend")=20
and it seems to work OK. The system suspends fine and no errors are=20
printed to the kernel log.

I am using Gentoo on the machine in question.

I didn't test the other patches you supplied. Let me know if there's=20
anything you would like me to test.

Thanks,
Alex.
