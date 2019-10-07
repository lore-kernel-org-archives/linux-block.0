Return-Path: <SRS0=HuTb=YA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7679BC47404
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 17:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8D421479
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 17:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cyberfiber.eu header.i=@cyberfiber.eu header.b="X2E2BsmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfJGRda (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:33:30 -0400
Received: from filter02-out8.totaalholding.nl ([185.56.145.240]:48287 "EHLO
        filter02-out8.totaalholding.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728028AbfJGRda (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Oct 2019 13:33:30 -0400
Received: from www98.totaalholding.nl ([185.94.230.81])
        by filter02.totaalholding.nl with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <mjbaars1977.linux-block@cyberfiber.eu>)
        id 1iHWsx-0000xG-8n
        for linux-block@vger.kernel.org; Mon, 07 Oct 2019 19:33:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberfiber.eu; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NAN+GroZC2IJWAYM1b71xYvhBPHqNS1YCqxw/+/qsng=; b=X2E2BsmPVbBwD4UzLWQcSP7/gI
        FB6f95xbroRtBA3dz7yIvK1OZN5qdRtfVuF6BbN03bjdoxGfezIDe56RW9LXJjPDl1cujn8vV2LpP
        360a8fyQVWmy+/q+c+rwkrJGM05dLUTotcLWz+CQiiEoOngw6biqOwrCbjXQU9dgdWdfpLYifnjFj
        3DDgC70l6JQeKwI58/wz6P2e7KjCHcWebp1qVocFyhGxAVY2KRfXk0TW4mI75k2rQgQWmuTLT3srR
        87jrAMd0bW9SAJ2U9KFRxbRjlydAfj4z/rdxF0nLLgle4lqzg1Pzrc0v3yYcueTE65oTW9F+PLCNh
        aYYWhgYg==;
Received: from 134-134-146-85.ftth.glasoperator.nl ([85.146.134.134]:60756 helo=DT0E.cyberfiber.eu)
        by www98.totaalholding.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <mjbaars1977.linux-block@cyberfiber.eu>)
        id 1iHWsx-00071e-Tc; Mon, 07 Oct 2019 19:33:27 +0200
Message-ID: <efe205abd54fe73d10df70388098631145a72962.camel@cyberfiber.eu>
Subject: Re: packet writing support
From:   Mischa Baars <mjbaars1977.linux-block@cyberfiber.eu>
To:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
Date:   Mon, 07 Oct 2019 19:31:54 +0200
In-Reply-To: <e507eb38-becf-b6a5-bb51-14f873aca28d@kernel.dk>
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
         <62ffa873794d2d6ced83bfc2a59d172677ef815c.camel@cyberfiber.eu>
         <e507eb38-becf-b6a5-bb51-14f873aca28d@kernel.dk>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.03)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ezqdolHG91LK5q2HN6uCHCpSDasLI4SayDByyq9LIhV3Rac7d6TOkMp
 fEdTdnA7jkTNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDrBQRDMCPoVIktGfXqz+K77w8
 BFityCCkxNlTi+jLDh0BcORxfCojcTOpEjtvWHp2eQyXEPH0KOQ1cmnIW+fnHjg9YkzbMy6DOYhG
 3MUcvhr5WSIV/ADayw0YwNNo7qOm8DjomP3d2Aqxr0VfVhf3qadxWf7PBaiEJ7Ubv24eC2q1gqil
 FjLFGSoqbEUSByQZF+KbsVJyJvk1v2cRMLfeu+j4c2f7whGZQeSjyr0GZKfGsic78ymdeM3VZEm7
 AV0/pE0L1o9YbzgtZN/a2BQSBQgqdb/JjbdVZfbc9c+Jxpt+54iyUCc8aaknZho9naJYg0bolM7B
 /rBFul0ycjYHG0NfDxtcqznH5VBUud8O4LV0JmbqROuof5+bHLNCgb4217NirEYyqwqMBGrw8ELi
 qO86tByCP69i0Qh5ndH5heRCJ7rPXZbjpKeI7vxRvveCIK/1NH5THMtlYvyHAYGOGgjdb5hy4d8/
 k+RlvkD7ATmoZ2kfng5rdXwjvpU4S+XA+ln3SmdyWNNJvR4I+Hp8ZWNeKErwtwuMGNtXyijhL/jm
 YBv9AL3pz0kEqfteKc/OXBE6o2GffRkde0GmoZ/iP9VnAwYmYPhCtjQveFc/ttqzpjogZOIQLFqr
 QNK2b8/y4JRq3UYHEt22IvIMKBSTlfO+aaj6wnK9h39sR8Y3Dzu1X2iVNki8izWZuQRxhjw0T1+z
 /gVqUXbO3Yb0X5mHnL+/FmMGCaXrQbl9a2H20+M33kiCfQIC3W4VGlLm/1IiF7I6vAoqMu7bH6bh
 5Tn1+ApfpnfqaBDETpAVW0am1AftxOzzT/YWdmD8gywgB151uK+wsnvd2XRh79oPsqvurHLa/P4e
 zC06EoqeDuStmICc1mvxWkfhDNLhFrRgdcJncNLOj0gyfC+E+JhwuM2loN6g5fMPPHW04q0LBG3v
 ooS/KWL2TW1pyb+uOnvvAx7DvnjL6OI0XUlLzsHhA6/79TEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@filter01.totaalholding.nl
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2019-10-07 at 10:19 -0600, Jens Axboe wrote:
> On 10/7/19 10:13 AM, Mischa Baars wrote:
> > On Mon, 2019-10-07 at 07:22 -0700, Bart Van Assche wrote:
> > > On 2019-10-07 02:17, Mischa Baars wrote:
> > > > On Mon, 2019-10-07 at 11:11 +0200, Mischa Baars wrote:
> > > > > necesarry
> > > > 
> > > > a) If necessary I could do the maintaining, sure.
> > > 
> > > You may want to start with having a look at the following:
> > > * pktcdvd: invalid opcode 0000 kernel BUG in pkt_make_request
> > > (https://bugzilla.kernel.org/show_bug.cgi?id=201481)
> > > * pktcdvd triggers a lock inversion complaint
> > > (https://bugzilla.kernel.org/show_bug.cgi?id=202745)
> > > 
> > > Thanks,
> > > 
> > > Bart.
> > 
> > I'm unable to reproduce these findings, also I'm unable to find any
> > executable or any manpage called pktsetup.
> 
> Let's put this to rest. You are not using pktcdvd in your current setup.
> You have apparently stumbled into some cdrom/dvd related regression if
> the burning stopped working for you, please see:
> 
> Documentation/admin-guide/reporting-bugs.rst
> 
> in the kernel tree for how to report that bug, separately. No further
> emails are needed in this thread.
> 

Thanks, but I'd rather enjoy that which is gained by all this, than the fly in the ointment. At least people can't sell any cheap CD's with stolen software
anymore :)

Regards,
Mischa.

