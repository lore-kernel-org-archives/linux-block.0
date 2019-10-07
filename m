Return-Path: <SRS0=HuTb=YA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F72C47404
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 14:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819B321655
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 14:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cyberfiber.eu header.i=@cyberfiber.eu header.b="rWI/ngzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfJGOiS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:38:18 -0400
Received: from filter02-out8.totaalholding.nl ([185.56.145.240]:42187 "EHLO
        filter02-out8.totaalholding.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727324AbfJGOiR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Oct 2019 10:38:17 -0400
Received: from www98.totaalholding.nl ([185.94.230.81])
        by filter02.totaalholding.nl with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <mjbaars1977.linux-block@cyberfiber.eu>)
        id 1iHU9K-0004XH-8n
        for linux-block@vger.kernel.org; Mon, 07 Oct 2019 16:38:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberfiber.eu; s=default; h=MIME-Version:Content-Type:References:
        In-Reply-To:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vXlEnW7uxfDNrcBLDoZfkteUHyR5Sbwhq7SKeHAenek=; b=rWI/ngzHaIEF5h0pj86Q03ZVO
        Vr2K7VndrFTFIT076+MAKVJme9Xz8oZPTHZAIOXa1QBOiErJVLuaVCMo3HV5wlxGUkWRJqniCTTXe
        W31LRsCyr6R7s/UQgkhBkPOo1hIGVvfQFLbPuqyySi3JMCKUEd51dcW0/FpjmZXK7mkldHpA/MQTm
        vOMx2bj/SZArrGF0NGRJrl9jG/TD6e8tdTsH9fhDrVZRRQedvFeZoyUnztWh5iyR10RKZz/pqO5nB
        bXVOzyf74QKxoP6f61BV6n/aRwRfHwowcNcA4JKE53q+LkXJaG9Y//8izfu52vjVZQbz0IOM8VW9/
        K6S03+CAA==;
Received: from 134-134-146-85.ftth.glasoperator.nl ([85.146.134.134]:60526 helo=DT0E.cyberfiber.eu)
        by www98.totaalholding.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <mjbaars1977.linux-block@cyberfiber.eu>)
        id 1iHU9K-0006Ml-Px; Mon, 07 Oct 2019 16:38:10 +0200
Message-ID: <eb7c0af84ec5540de5deec169e25cf0170a3ec9b.camel@cyberfiber.eu>
Subject: Re: packet writing support
From:   Mischa Baars <mjbaars1977.linux-block@cyberfiber.eu>
To:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Date:   Mon, 07 Oct 2019 16:36:37 +0200
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
Content-Type: multipart/mixed; boundary="=-I19Vt6XpW+KxrfAip5cV"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.0080542178769)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0ezqdolHG91LK5q2HN6uCHCpSDasLI4SayDByyq9LIhVmulwsLO2M/6i
 b8vFPSm67ETNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGDrBQRDMCPoVIktGfXqz+K77w8
 BFityCCkxNlTi+jLDh0BcORxfCojcTOpEjtvWHp2gB1Zz65v5usbUMiOXriuIjg9YkzbMy6DOYhG
 3MUcvhr5WSIV/ADayw0YwNNo7qOm8DjomP3d2Aqxr0VfVhf3qadxWf7PBaiEJ7Ubv24eC2q1gqil
 FjLFGSoqbEUSByQZF+KbsVJyJvk1v2cRMLfeu+j4c2f7whGZQeSjyr0GZKfGsic78ymdeM3VZEm7
 AV0/pE0L1o9YbzgtZN/a2BQSBQgqdb/JjbdVZfbc9c+Jxpt+54iyUCc8aaknZho9naJYg0bolM7B
 /rBFul0ycjYHG0NfDxtcqznH5VBUud8O4LWGDhKZrP8vIj7OJOFHtFcAx/uHb14MwCWpSzBowjvL
 n7wqyT5p50x81ZKcmzCu2U0u+3yDnE2dEMkoa9Z2pIU4jZrPG4cX3tpyKcJIokDIf9hDlN3ZFexZ
 fYgAG9qTPTrzvgwP9cMw+lye/qXkeuruM49zcQbne4vePgcv4iEyyps9zSZic0xNU+sMoNUh1wuv
 1+pbZnXT+Q8GBcRHUOaD4nuZrRf7bMi0WRR6pZ+nWYN1nUsyg/vfWsp+m0i9sl7mkP6G1Z7t7snr
 DmHhJsMc+sG98z687Xg7dEus4dfHqhCrvq80XID73lkmMr7ffmSMa4jysxIAo3LM+CTylHyzQ2K5
 UjhgJmfm3gS/XH6VT8K8Lkg4GK4OULRJw+zEz6mFJU6yUrSgk/ybCvnnlpQPFdg0XBpXD8r6EvwE
 IcoKD6twgRp2ViCPZ4Fd+lKgnIpFjMRZIjL7uQ58IAQVH8CDfqb5R4VemuUI6bcEARsm0EmAr/Al
 K+7l7FTTeHBnN98HKjGhOrpFrPywBnJjRpvPyox8g1sLxZmIhuo0f21FQF0GVtGdsQXxd6SsQe8E
 FqC0i8h4hG8E7FuqMX9EnKWAqWf8dvwaZ5Z2WXiFTGFEyFIwvKwp+F/RAXnyBiVVmuP2OKHH5lr9
 xXvSM4nM3avg
X-Report-Abuse-To: spam@filter01.totaalholding.nl
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--=-I19Vt6XpW+KxrfAip5cV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

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

Hi Bart,

Unfortunately, I'm unable to reproduce your findings.

This is what shows up in my dmesg output:

[  166.135611] usb 1-6: new high-speed USB device number 5 using xhci_hcd
[  166.272735] usb 1-6: New USB device found, idVendor=0e8d, idProduct=1887, bcdDevice= 0.00
[  166.272749] usb 1-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  166.272756] usb 1-6: Product: Portable Super Multi Drive
[  166.272762] usb 1-6: Manufacturer: Hitachi-LG Data Storage Inc
[  166.272767] usb 1-6: SerialNumber: K50H4EL4125         
[  166.543625] usb-storage 1-6:1.0: USB Mass Storage device detected
[  166.545207] scsi host2: usb-storage 1-6:1.0
[  166.545951] usbcore: registered new interface driver usb-storage
[  167.600103] scsi 2:0:0:0: CD-ROM            ASUS     SDRW-08D2S-U     A801 PQ: 0 ANSI: 0
[  167.605529] sr 2:0:0:0: Power-on or device reset occurred
[  167.611257] sr 2:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[  167.611269] cdrom: Uniform CD-ROM driver Revision: 3.20
[  167.615920] sr 2:0:0:0: Attached scsi CD-ROM sr0
[  167.616339] sr 2:0:0:0: Attached scsi generic sg0 type 5

Nothing strange, but when I do 'fdisk -l' nothing shows up. I'm not only unable to write, but also unable to read DVD's.

Regards,
Mischa.

--=-I19Vt6XpW+KxrfAip5cV
Content-Disposition: attachment; filename="dmesg.log"
Content-Transfer-Encoding: base64
Content-Type: text/x-log; name="dmesg.log"; charset="UTF-8"

WyAgMTY2LjEzNTYxMV0gdXNiIDEtNjogbmV3IGhpZ2gtc3BlZWQgVVNCIGRldmljZSBudW1iZXIg
NSB1c2luZyB4aGNpX2hjZApbICAxNjYuMjcyNzM1XSB1c2IgMS02OiBOZXcgVVNCIGRldmljZSBm
b3VuZCwgaWRWZW5kb3I9MGU4ZCwgaWRQcm9kdWN0PTE4ODcsIGJjZERldmljZT0gMC4wMApbICAx
NjYuMjcyNzQ5XSB1c2IgMS02OiBOZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MSwgUHJvZHVj
dD0yLCBTZXJpYWxOdW1iZXI9MwpbICAxNjYuMjcyNzU2XSB1c2IgMS02OiBQcm9kdWN0OiBQb3J0
YWJsZSBTdXBlciBNdWx0aSBEcml2ZQpbICAxNjYuMjcyNzYyXSB1c2IgMS02OiBNYW51ZmFjdHVy
ZXI6IEhpdGFjaGktTEcgRGF0YSBTdG9yYWdlIEluYwpbICAxNjYuMjcyNzY3XSB1c2IgMS02OiBT
ZXJpYWxOdW1iZXI6IEs1MEg0RUw0MTI1ICAgICAgICAgClsgIDE2Ni41NDM2MjVdIHVzYi1zdG9y
YWdlIDEtNjoxLjA6IFVTQiBNYXNzIFN0b3JhZ2UgZGV2aWNlIGRldGVjdGVkClsgIDE2Ni41NDUy
MDddIHNjc2kgaG9zdDI6IHVzYi1zdG9yYWdlIDEtNjoxLjAKWyAgMTY2LjU0NTk1MV0gdXNiY29y
ZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciB1c2Itc3RvcmFnZQpbICAxNjcuNjAw
MTAzXSBzY3NpIDI6MDowOjA6IENELVJPTSAgICAgICAgICAgIEFTVVMgICAgIFNEUlctMDhEMlMt
VSAgICAgQTgwMSBQUTogMCBBTlNJOiAwClsgIDE2Ny42MDU1MjldIHNyIDI6MDowOjA6IFBvd2Vy
LW9uIG9yIGRldmljZSByZXNldCBvY2N1cnJlZApbICAxNjcuNjExMjU3XSBzciAyOjA6MDowOiBb
c3IwXSBzY3NpMy1tbWMgZHJpdmU6IDI0eC8yNHggd3JpdGVyIGR2ZC1yYW0gY2QvcncgeGEvZm9y
bTIgY2RkYSB0cmF5ClsgIDE2Ny42MTEyNjldIGNkcm9tOiBVbmlmb3JtIENELVJPTSBkcml2ZXIg
UmV2aXNpb246IDMuMjAKWyAgMTY3LjYxNTkyMF0gc3IgMjowOjA6MDogQXR0YWNoZWQgc2NzaSBD
RC1ST00gc3IwClsgIDE2Ny42MTYzMzldIHNyIDI6MDowOjA6IEF0dGFjaGVkIHNjc2kgZ2VuZXJp
YyBzZzAgdHlwZSA1Cgo=


--=-I19Vt6XpW+KxrfAip5cV--

