Return-Path: <SRS0=c18M=VS=vmcp04.web-servers.com.au=nrasprop@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTML_MIME_NO_HTML_TAG,
	LOTS_OF_MONEY,MIME_HTML_ONLY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D1BC76188
	for <linux-block@archiver.kernel.org>; Sun, 21 Jul 2019 13:17:45 +0000 (UTC)
X-Greylist: delayed 2069 seconds by postgrey-1.34 at mail.kernel.org; Sun, 21 Jul 2019 13:17:45 UTC
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=vmcp04.web-servers.com.au header.i=@vmcp04.web-servers.com.au header.b="Ib7v/xky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FBA20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=5degrees.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=nrasprop@vmcp04.web-servers.com.au
Received: from out103-7-vmse02.mailcluster.com.au (out103-7-vmse02.mailcluster.com.au [103.250.20.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10FBA20828
	for <linux-block@archiver.kernel.org>; Sun, 21 Jul 2019 13:17:44 +0000 (UTC)
Received: from vmcp04.web-servers.com.au ([116.90.56.33])
	by vmse02.mailcluster.com.au with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.89)
	(envelope-from <nrasprop@vmcp04.web-servers.com.au>)
	id 1hpBBC-0000IQ-Fl
	for linux-block@archiver.kernel.org; Sun, 21 Jul 2019 22:43:13 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=vmcp04.web-servers.com.au; s=default; h=Content-Type:MIME-Version:Reply-To:
	Message-ID:From:Date:Subject:To:Sender:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	 bh=DNK7P1YCteFDghwzOpcrIh1DVCQu60wPr1+lrESi3lE=; b=Ib7v/xky61kw53/XGFjEqQdOC
	vlTpTgWNVX8xPJ0R1NRIqo6dEKu26EEt6l4dZ7xPoLXmLlLX9i8JEj6Fvg7OC1xRNUCQdtDG4DtkH
	L0p6cNI+gChwirvn1NXJOh3Vp+TJ3mJ1wl28J8sS5ZklfD3u4J0z8h0iHjlJ5Q2AwI++vjw5ZZudL
	gihrEwgjQR2qQ9jT6m53egBptXG6a2+QRTUkAHUCa1eOsmfhSt3vuoWst70CuP+YbdppkhWha7OUw
	N6D2EB1N8An9VDPtGTz+DkPrCY4Ze8FexKPDRl7Lxj8qQKrsmys6XXMHfYDpfOneYZcEt3zx3hNG5
	V9/XrEDFw==;
Received: from nrasprop by vmcp04.web-servers.com.au with local (Exim 4.92)
	(envelope-from <nrasprop@vmcp04.web-servers.com.au>)
	id 1hpBBB-001tFn-Jt
	for linux-block@archiver.kernel.org; Sun, 21 Jul 2019 22:43:05 +1000
To: linux-block@archiver.kernel.org
Subject: Dual Property Australia Enquiry
X-PHP-Script: dualpropertyaustralia.com.au/index.php for 77.243.191.44
X-PHP-Filename: /home/nrasprop/public_html/dualpropertyaustralia.com.au/index.php REMOTE_ADDR: 77.243.191.44
Date: Sun, 21 Jul 2019 12:43:05 +0000
From: Dual Property Australia <info@5degrees.com.au>
Message-ID: <74b51a68e325e5b9c0cdd8addf130545@dualpropertyaustralia.com.au>
X-Mailer: PHPMailer 5.2.22 (https://github.com/PHPMailer/PHPMailer)
Reply-To: info@5degrees.com.au
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
X-Originating-User: nrasprop
X-Originating-IP: 116.90.56.33
X-SpamExperts-Domain: panthur-sh-outbound0.mailcluster.com.au
X-SpamExperts-Username: 116.90.56.33
Authentication-Results: mailcluster.com.au; auth=pass smtp.auth=116.90.56.33@panthur-sh-outbound0.mailcluster.com.au
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.15)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0U6y6flTXvu8AHhQTLy0w52pSDasLI4SayDByyq9LIhVUZbR67CQ7/vm
 /hHDJU4RXkTNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDOMM/E0YawTI73Oj2ZOn9jH4E
 6WLQ03ZXGgcFEnWnhSbEV6mG7REFdc/y+N+WUcRUhsKlbfTRvGei6HNEo3arXvq2Gb7u1BCYlN7N
 u1YChzsJPET7MGwswUbNzNzkeypfxPwEYhaaJqGpdnqXCNzEdGacBy+adnhKPbnYB6oy8y/QzE4p
 WsN9DMOCoUO6aPH3MBUeNie1H16XM9q9pELARC15ZgutLZiUUacMy6CG3+UUfD5/+GVWjLSk8Y+P
 5Nufm7Qe/hUsZR7mCBEb3UTf0TWT1ROSHyDiBeBLUm2EJjY7qMHeEyGqLuUiq+ezIOEQoUV4ErIQ
 V98lxgrJEntTdN7fPl6Cm4NQYtT7e3ZKeiYFL6LLI2ptPx1Qxcwni1QIyPobftl8Awtx4/lo0c+3
 bsUk+G+m3d2AUW+3rc5DeqgK9fnQWo+c6PHHfKw2XXUy1VrKZQeacULUSS3yomLM7SdaACh8dah4
 7zhl5ukAfppOmU8wjyrBX7cMW5IOTkxCQUmQ8RXTHY4VikEbNcut+L6DMVlksKHafZqBUEAb4Ygj
 qNTMITk1MFQ/fSJpBwaaMwHBDDw5R7th+5yCe7vLg2LvAuZiee2RvYPUH2waSBeO5II36Hi3vcav
 cB1ZYo2AEBksfbu9yLQMc7lcHkHFV/djzQ6YC7Heg3Xf7O1TOd7U2Q4Rn8rDcGjXX7KUYQAkz/jg
 KJgu1Gmdfr82Mew1fKKZOqyflCVNHKP4psv+TE13BqNBgyQVgsq4/8KR9J4lXPWlFdaGOH191uXj
 gjQN/bp7nF89UGOvNhgPqMbY/lv2ESjwnI8pHdp066i61N3KNjAwflcG5Oq8/l7JFcDOCDcDkZ/B
 UvAgs4nPJ+M2/DCgcRBJ/ZgqLqeUwG0R12svmEDJ7jgeHcJTevWg8+R1jgFehep93Fnpexz1pshK
 rgJ73n4rNOK4erw+M/WuBl/lgaffDh0pp7mBpDw4+w7wF+ICUTIqG9GP/0y/T4/wTA+aCw5Hn2sA
 2GefVUqTY2dxMS+4ayUpOtEhdxekWDmK9g==
X-Report-Abuse-To: spam@vmse01.mailcluster.com.au
List-Id: <linux-block.vger.kernel.org>

Hello WilliamGof,<br />
<br />
Thanks for the inquiry about our current Dual-income property portfolio. We have a large number of projects, and I'll ensure to contact you shortly to discuss them, and find out exactly what you're looking for.<br />
<p style="text-align: justify;">We are a real estate broker and sourcing consultants with exclusive access to new properties Queensland, and Australia, wide. Primarily sourcing dual properties for our clients, we are independent of any one developer or builder, meaning we can provide a solution tailored to our client, rather than being limited by a set list of properties.</p><br />
<p style="text-align: justify;">Due to the fast moving marketing, our database change daily. As such, rather than providing the details of all of the projects, we tailor a custom portfolio that suits your search requirements.</p><br />
If you have any questions regarding our properties, please don't hesitate in contacting me.<br />
<br />
&nbsp;<br />
<div><br />
<div class="gmail_signature" data-smartmail="gmail_signature"><br />
<div dir="ltr"><br />
<div><br />
<div dir="ltr"><br />
<div><br />
<div dir="ltr"><br />
<div><br />
<div dir="ltr"><br />
<div><br />
<div dir="ltr"><br />
<div><br />
<div dir="ltr"><br />
<div><br />
<div dir="ltr"><br />
<div><br />
<div dir="ltr"><br />
<div dir="ltr">Regards,<br />
<br />
<i>Andrew Herbert</i><br />
<b>Principal Partner</b><br />
<i><span style="font-size: xx-small;">MBA, LREA, 2018 EO QLD Board</span></i></div><br />
<div dir="ltr"><i></i><br />
w: 07 3193 2533<br />
m: 0411 332 644<br />
<br />
<i><span style="font-size: xx-small;"><span style="text-decoration: underline;">About Us:</span><br />
- </span></i><i><span style="font-size: xx-small;">We have supported <span style="text-decoration: underline;">$101m</span>+ in purchases since 2015 </span></i></div><br />
<i><span style="font-size: xx-small;">- <a href="http://www.afr.com/leadership/afr-lists/fast-starters/financial-review-fast-starters-2017-the-full-list-20171103-gzeezw" target="_blank">BRW Fast Starter 2017</a> award winner &amp; member of </span></i><i><span style="font-size: xx-small;"><a href="https://www.eonetwork.org/" target="_blank">Entrepreneurs Organisation</a><br />
- Certified <a href="http://bcorporation.com.au/what-are-b-corps-0" target="_blank">B Corp</a> and an <a href="http://www.avob.com.au/" target="_blank">Australian Veteran Owned Business</a></span></i></div><br />
</div><br />
</div><br />
</div><br />
</div><br />
</div><br />
</div><br />
</div><br />
</div><br />
</div><br />
</div><br />
</div><br />
</div><br />
</div><br />
</div><br />
</div><br />
</div><br />
&nbsp;<br />
<br />
&nbsp;

