Return-Path: <SRS0=HuTb=YA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F0BC47404
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 16:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F552067B
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 16:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cyberfiber.eu header.i=@cyberfiber.eu header.b="OlY9IAAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfJGQOk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:14:40 -0400
Received: from filter02-out8.totaalholding.nl ([185.56.145.240]:35327 "EHLO
        filter02-out8.totaalholding.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727711AbfJGQOk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Oct 2019 12:14:40 -0400
Received: from www98.totaalholding.nl ([185.94.230.81])
        by filter02.totaalholding.nl with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <mjbaars1977.linux-block@cyberfiber.eu>)
        id 1iHVee-0002pb-P5
        for linux-block@vger.kernel.org; Mon, 07 Oct 2019 18:14:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberfiber.eu; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bSW2Iqmla6rEXjin1LF8zX6OBkdG4gVY2v8pDw1whUA=; b=OlY9IAAH3nnrZv6TMf3UasXnmu
        UsYw2zExzSBPFvnQ9b7TDFMvAUVRqHiHEULiFO6yoRr2lhIqef74ZgRAGpDGU6t7dpXpnFTz3Yyui
        bs6TKM4Ilviqa3Gw8mEKVi/DVKXSyiXgAOXzOFtL8xl5AOp6paKNuJ8Py7tql2O87S5uRTjGWSu6n
        ZP7NFsxpnEC9J8J4R4Wfogi7JDhR7L5NEkQfc/Oplq49m+RBw3UZsaE8gUtjehSXL6EgOg8a1FIP8
        hzKo+wADf77Ucm3A0AYZp6mpRvCKNkerOsg2Bhf8n2ivg16oeNMjv9csLUstLf51QBiP+DTqDRIDk
        odXQUzig==;
Received: from 134-134-146-85.ftth.glasoperator.nl ([85.146.134.134]:60652 helo=DT0E.cyberfiber.eu)
        by www98.totaalholding.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <mjbaars1977.linux-block@cyberfiber.eu>)
        id 1iHVef-0002mo-CE; Mon, 07 Oct 2019 18:14:37 +0200
Message-ID: <62ffa873794d2d6ced83bfc2a59d172677ef815c.camel@cyberfiber.eu>
Subject: Re: packet writing support
From:   Mischa Baars <mjbaars1977.linux-block@cyberfiber.eu>
To:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Date:   Mon, 07 Oct 2019 18:13:03 +0200
In-Reply-To: <844e6f57-d97d-0c2e-1493-a356cd792a8a@acm.org>
References: <db5c89c3fe26e4b7ec96443ec97a05df97162889.camel@cyberfiber.eu>
         <6e381f83-9a12-30d7-8f99-caaa6a608c4f@kernel.dk>
         <a4b89c40caf62166ab7078296d73b6ae0f35adaf.camel@cyberfiber.eu>
         <fc70b63f-3780-5654-6bc5-0f2d6115bff0@kernel.dk>
         <6c51a5fe93cfad0f76fdbfe47caaa5f5d3f1ca88.camel@cyberfiber.eu>
         <71a450ed-3f52-fb3a-b0fa-3a08bdc4b3f6@suse.de>
         <977cedab873dfe0705701b3b43c621a7a516e396.camel@cyberfiber.eu>
         <ce56abfd-f309-5471-0201-6226731fa452@suse.de>
         <6eb30ce355f90eca126cbd2f11d359db2bbe69f1.camel@cyberfiber.eu>
         <9596b5fe35dbab5f7804308167bb67b5e6cde52b.camel@cyberfiber.eu>
         <844e6f57-d97d-0c2e-1493-a356cd792a8a@acm.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - www98.totaalholding.nl
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - cyberfiber.eu
X-Get-Message-Sender-Via: www98.totaalholding.nl: authenticated_id: mjbaars1977.linux-block@cyberfiber.eu
X-Authenticated-Sender: www98.totaalholding.nl: mjbaars1977.linux-block@cyberfiber.eu
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Originating-IP: 185.94.230.81
X-SpamExperts-Domain: out.totaalholding.nl
X-SpamExperts-Username: 185.94.230.81
Authentication-Results: totaalholding.nl; auth=pass smtp.auth=185.94.230.81@out.totaalholding.nl
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ezqdolHG91LK5q2HN6uCHCpSDasLI4SayDByyq9LIhVKPU1vtcVWnK0
 C6X6YhNNcUTNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDrBQRDMCPoVIktGfXqz+K77w8
 BFityCCkxNlTi+jLDh0BcORxfCojcTOpEjtvWHp25WOsMTkEhhCGfAq96zeAujg9YkzbMy6DOYhG
 3MUcvhr5WSIV/ADayw0YwNNo7qOm8DjomP3d2Aqxr0VfVhf3qadxWf7PBaiEJ7Ubv24eC2q1gqil
 FjLFGSoqbEUSByQZF+KbsVJyJvk1v2cRMLfeu+j4c2f7whGZQeSjyr0GZKfGsic78ymdeM3VZEm7
 AV0/pE0L1o9YbzgtZN/a2BQSBQgqdb/JjbdVZfbc9c+Jxpt+54iyUCc8aaknZho9naJYg0bolM7B
 /rBFul0ycjYHG0NfDxtcqznH5VBUud8O4LV0JmbqROuof5+bHLNCgb4217NirEYyqwqMBGrw8ELi
 qO86tByCP69i0Qh5ndH5heRCJ7rPXZbjpKeI7vxRvveCIK/1NH5THMtlYvyHAYGOGgjdb5hy4d8/
 k+RlvkD7ATmoZ2kfng5rdXwjvpU4S+XA+ln3SmdyWNNJvR4I+Hp8ZWNeKErwtwuMGNtXyijhL/jS
 4bha6ybh3bccXW4J31FMAwUk1YFRpM6nvb4CFPYEItVnAwYmYPhCtjQveFc/ttqzpjogZOIQLFqr
 QNK2b8/y4JRq3UYHEt22IvIMKBSTlfO+aaj6wnK9h39sR8Y3Dzu1X2iVNki8izWZuQRxhjw0T1+z
 /gVqUXbO3Yb0X5mHnH50ChNqStb0V7f79hJ7rF9sZHplrLdyEWMeOy73V5AhF7I6vAoqMu7bH6bh
 5Tn1+ApfpnfqaBDETpAVW0am1AftxOzzT/YWdmD8gywgB151uK+wsnvd2XRh79oPsqvurHLa/P4e
 zC06EoqeDuStmICc1mvxWkfhDNLhFrRgdcJncNLOj0gyfC+E+JhwuM2loN6g5fMPPHW04q0LBG3v
 ooS/KWL2TW1pyb+uOnvvAx7DvnjL6OI0XUlLzsHhA6/79TEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@filter01.totaalholding.nl
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2019-10-07 at 07:22 -0700, Bart Van Assche wrote:
> On 2019-10-07 02:17, Mischa Baars wrote:
> > On Mon, 2019-10-07 at 11:11 +0200, Mischa Baars wrote:
> > > necesarry
> > 
> > a) If necessary I could do the maintaining, sure.
> 
> You may want to start with having a look at the following:
> * pktcdvd: invalid opcode 0000 kernel BUG in pkt_make_request
> (https://bugzilla.kernel.org/show_bug.cgi?id=201481)
> * pktcdvd triggers a lock inversion complaint
> (https://bugzilla.kernel.org/show_bug.cgi?id=202745)
> 
> Thanks,
> 
> Bart.

I'm unable to reproduce these findings, also I'm unable to find any executable or any manpage called pktsetup.

Mischa.

