Return-Path: <SRS0=vHgh=AF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBE4C433DF
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 09:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F8EF2088E
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 09:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="tzqcZ7Dp";
	dkim=pass (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="tzqcZ7Dp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390038AbgFXJsQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jun 2020 05:48:16 -0400
Received: from fallback13.mail.ru ([94.100.179.30]:33304 "EHLO
        fallback13.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390004AbgFXJsP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 05:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:Date:To:From:Subject:Message-ID; bh=24yX8Pt7mqBbFrtKpiFg908fim78FNe+L9nZ0oX8SEU=;
        b=tzqcZ7Dp81CE1EYpW4QGVOeJd5N18TowZYI5h6IWETFbazNWTLDC+kosnuo7vsreqOSHLLpt/kVUmnAqaIyyZPrHXONN2P/TGAC2QEIRbq7iexrlEC49qKzgOAgJVD+9ny+1GkBriuSR7M+eiMhxs98D0gkQnPJ++ebOLcoFFNo=;
Received: from [10.161.25.39] (port=58100 helo=smtp62.i.mail.ru)
        by fallback13.m.smailru.net with esmtp (envelope-from <alekseymmm@mail.ru>)
        id 1jo20r-0002Bt-6P
        for linux-block@vger.kernel.org; Wed, 24 Jun 2020 12:48:13 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:Date:To:From:Subject:Message-ID; bh=24yX8Pt7mqBbFrtKpiFg908fim78FNe+L9nZ0oX8SEU=;
        b=tzqcZ7Dp81CE1EYpW4QGVOeJd5N18TowZYI5h6IWETFbazNWTLDC+kosnuo7vsreqOSHLLpt/kVUmnAqaIyyZPrHXONN2P/TGAC2QEIRbq7iexrlEC49qKzgOAgJVD+9ny+1GkBriuSR7M+eiMhxs98D0gkQnPJ++ebOLcoFFNo=;
Received: by smtp62.i.mail.ru with esmtpa (envelope-from <alekseymmm@mail.ru>)
        id 1jo20p-0002UH-3J
        for linux-block@vger.kernel.org; Wed, 24 Jun 2020 12:48:11 +0300
Message-ID: <31f1b935095940801e8f8eafee9ecb29ba701f79.camel@mail.ru>
Subject: Question about quiet bio, quiet requests
From:   Aleksei Marov <alekseymmm@mail.ru>
To:     linux-block@vger.kernel.org
Date:   Wed, 24 Jun 2020 12:48:05 +0300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9AAC5A87EC32CE31E196090AC2CBDFADCC97DA7FD68450178182A05F5380850407F348DCDFEAE6E43795556C00B551E29C184378555AFE36B72B0F54D1ED31269
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE75DF2B1F23425CAE5EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063716A4A39B750036BB8638F802B75D45FF5571747095F342E8C7A0BC55FA0FE5FC07D67EA179F39D624EBF3D205769B9CBEC736E1784124E79389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C0565C7A4E90E531F78941B15DA834481FCF19DD082D7633A0E7DDDDC251EA7DABA471835C12D1D977725E5C173C3A84C3A12191B5F2BB8629117882F4460429728AD0CFFFB425014E40A5AABA2AD371193AA81AA40904B5D9A18204E546F3947C51C368AE3DEE0FB99735652A29929C6C4AD6D5ED66289B52F4A82D016A4342E36136E347CC761E07725E5C173C3A84C3FBF5921B65700383BA3038C0950A5D36B5C8C57E37DE458BC67205D6E5191FA967F23339F89546C55F5C1EE8F4F765FCDCE939D40DBB93CA75ECD9A6C639B01BBD4B6F7A4D31EC0BC0CAF46E325F83A522CA9DD8327EE4930A3850AC1BE2E73557739F23D657EF2BB5C8C57E37DE458B4C7702A67D5C3316FA3894348FB808DBA1CE242F1348D5363B503F486389A921A5CC5B56E945C8DA
X-C8649E89: 6452211541F032DB41C90D3F60D6C9C463E5EFA8149360547D407D72FB2CA5F05729F56A71EEF0DF
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojwT8iZ7K/0gDmosAs8OjiNA==
X-Mailru-Sender: 8261CADE3D3FA0B4BDFD1058942BD7EAF6505EE2C3EF716129722D1F69363711C15667D5CFEC4B13FEDCCAD94ABAB60078274A4A9E9E44FD4301F6103F424F867A458BE9B16E12C867EA787935ED9F1B
X-Mras: Ok
X-7564579A: EEAE043A70213CC8
X-77F55803: E8DB3678F13EF3E07F9F52485CB584D7271FD7DF62800FDC0B2E87A62D9491CCF7209C7E249580F024F7640C27B02C7B46D7FBB688A2FC9C
X-7FA49CB5: 0D63561A33F958A5927D73881812E57FF1FCEDA2CB5D6DC37E1454E73CCEAA6E8941B15DA834481FA18204E546F3947C6089696B24BB1D19F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B974A882099E279BDA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249EF499754DBF6557476E601842F6C81A12EF20D2F80756B5F7874E805F1D05189089D37D7C0E48F6CA18204E546F3947C83C798A30B85E16B5E1C53F199C2BB95C8A9BA7A39EFB7666BA297DBC24807EA089D37D7C0E48F6C8AA50765F79006371F24DFF1B2961425731C566533BA786A40A5AABA2AD371193C9F3DD0FB1AF5EBDFC194086D65061027F269C8F02392CD5571747095F342E88FB05168BE4CE3AF
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojwT8iZ7K/0gCYVkEG0yxJJA==
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C9005DCCD83CE6875A18E41E20F7BE8BB8182F7209C7E249580F0E978AD604E751615BA06D6758C6957D0C77752E0C033A69EE9C7C6BE7440F28B4CF838113C6AC4B43453F38A29522196
X-Mras: Ok
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello everyone, I am new to this mail list and have a bit silly
question. In my project, I allocate and submit bio to blk-mq block
device, which in my case is dev from other node presented by nvmeof. I
handle these bio on the other node (can complete them with BLK_STS_OK
or error).
My question is it possible to make blq_mq requests quiet, for example
by somehow passing RQF_QUIET  to blk_mq reuests rq->rq_flags. I mean I
can set bio_set_flag(bio, BIO_QUIET)  before submitting bio to lower mq
block dev, but it seems to me that this bio flag is ignored later.

The problem I am trying to solve by making reqs quiet is when I handle
bio on the other side and complete it with error, I got a lot of

print_req_error: 49324 callbacks suppressed
blk_update_request: I/O error, dev nvme0c0n1, sector 0 op 0x1:(WRITE)
flags 0x4021800 phys_seg 1 prio class 0
blk_update_request: I/O error, dev nvme0c0n1, sector 0 op 0x1:(WRITE)
flags 0x4021800 phys_seg 1 prio class 0
...

where I submitted bio. I handle those error bio properly in my
bii_end_io. But I am looking for some way of not spamming those
print_req_error messages from blk_update_request. Any thoughts
appreciated.

Thanks in advance
Alex

