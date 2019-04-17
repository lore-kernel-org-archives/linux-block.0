Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D046C282DA
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 21:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD9A2183E
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 21:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ahVNkPW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfDQVxa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:53:30 -0400
Received: from mout.web.de ([212.227.15.4]:34901 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbfDQVxa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Apr 2019 17:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1555538006;
        bh=tAIU2MX5C+RDnAFZClySY77Xnj/34BeXjYcMjTQI33M=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=ahVNkPW8spXP/+LekbcaoI7Ty/BrWKnL+FY8GfJhB7GYeE7KTB+WqKk9l97UDoodh
         /La1WEJGdVeTqTKtSxBAjfsZ6hSi8OECGH7jawnQ8A+MbmN+Cb1nPbZ/1MYJBdiAN2
         D6qeGinCeEYWVEgbST5xIJwMqLJkYB1/aa093Oak=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from laptop.manuel.cli.intranet ([109.192.218.194]) by smtp.web.de
 (mrweb002 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MBkWd-1h67vd2zPr-00An85; Wed, 17 Apr 2019 23:53:26 +0200
Subject: Re: Adding QCOW2 reading/writing support
To:     Hannes Reinecke <hare@suse.de>
References: <60bbe5e0-317d-8ead-0eb8-d1dc79927bc8@web.de>
 <c6b31507-bb02-c886-aea6-4165606f215d@suse.de>
From:   Manuel Bentele <manuel-bentele@web.de>
Openpgp: id=5260D26DAE5C7FDF3113C572EC7CB9F864CA371E
Autocrypt: addr=manuel-bentele@web.de; prefer-encrypt=mutual; keydata=
 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
Cc:     linux-block@vger.kernel.org
Message-ID: <762bceb9-c66c-0a45-7d6b-e5ed0df56cbf@web.de>
Date:   Wed, 17 Apr 2019 23:53:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c6b31507-bb02-c886-aea6-4165606f215d@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:cTyPHx0iEwyAGrln6Aq2RLsLOKCxK2/fLSkw/2ZQb5Flxr+riQv
 lH2waWyQODbf42ARX9FjBYNwfY8fKgGzYzwWqELNLA4rNrzix+2/v4wvWIkAekfBNXKkO8X
 W2Awcorv3l9zFxMJdAtnCKO5l1KQPsyicTqXHegLyaIwX2zJzsU6V5HyMLsRmPnr7jybbWs
 2n2qn90TCtlYWNDe/7wcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SSNjNfnGZnA=:aE1KoXCiv2s/D7a+DwQgYS
 tTQI9pZHdlxi9Cbv2pMKe11CO8z2Yig1HDXcxeibCOSNDNs73XPO3XK8zCcINZ8WNRl2ORYy4
 VYmkkj4fKzXcN4fs/Xnz+/MBbFWVqib/YLV16oJPYIXUnnAYSeWBEp9PxjBDsW67zT8Q0XbYQ
 0kYEDdOW8AfjomrH4Zb4SrooXkTQour8Lj2gRnbAOV1yIvwSYH0QX8HhoVE63Rf7LY2MEM/Gz
 SA8CG+nL4HFZyhl1PClQUuJ3g+7sb87+UcPtYRYRu/dkPYmoGVazjsiACf3Fd7thAbnVcMozu
 AREVcTAouPnXTtUF7Q1NJ3i7SNRwQAB408b1koo02x0+rwoMZiJcHeIe2I0poDIugBdQRViC/
 /d6ocHi/G/zo4WIEDJ5w7U/0+Izd/TN8tcxgz6l3HNObTVx3cdY3xHd9q2Sj3O7bpDFd+GPzc
 0SLnggjKwNNn5KWT+use65O9vHr2Xd3AXHSqNcqL75wt1er/aNhjy3B76nT4TN3emLfDlnMim
 5XqxvVm0ryvL0PaBilmvoYKag4XB43QSl5buFJv3y0mYY7l2tvQhmkmVF65lKnUOfWhzOPw/L
 W5CGgtvSVEs2MVfJg3iHHP/uaMtadENvf+BNO7vaFqfTU+sm5ReDUgSKt03eGRYOBuQ1bf7R0
 RZSLpyYG721Z+MbeAyY/kRLtvLqfNz5W7Ej/Jh+u3952vLtqkisF2tGXGe43VGXaoxJ9F/Ked
 uxDOJLi1wn9l5pzswLtGbm1+vy+9gwz6VlTiDd/FwoxUmolFAHdeBv/rW7Cg6na3n9MLzwIyE
 VEM+b6SpjWRo4wNm921jNVmEjY6laAfyHX99QOGdlnTNL9C/3Q9eRCQZwZ7L+DDCyI1keVZlK
 e4E+g5ANkpfaDjGTgbmyhWe9TxEbGfn/iCPnoIRGkh9pDdrJjn+lKJSOqzmZYjCuvylfZpBHB
 BpKXBaJ9vyQ==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 17.04.19 13:58, Hannes Reinecke wrote:
> On 4/16/19 11:30 PM, Manuel Bentele wrote:
>> Hi everyone
>>
>> I'm going to implement an in-kernel reading of QCOW2 images.
>> In the project, I only need the reading of QCOW2 images, but it's
>> essential to make thoughts for the implementation of the writing, too.=

>> One of the difficulties seems to be the support of making an image
>> sparse (resizing the disk image).
>>
>> Now, I want to ask you for advice: What is the best approach to achiev=
e
>> this?
>>
>> =C2=A0=C2=A0 * Implement the reading/writing in the device mapper?
>> =C2=A0=C2=A0 * Extend the loop device?
>> =C2=A0=C2=A0 * Create a new subsystem for the processing of sparse dev=
ices or
>> images?
>>
>> Or do you have any other idea?
>>
> I'm not sure if that would be met with universal acclaim; file formats
> are regarded as userland policies, and shouldn't be handled in the
> kernel at all.
> Have you looked at fuse?
>
> Cheers,
>
> Hannes
I agree with your notice that file formats should stay outside the
kernel space.
Fuse would be a very good approach to reach the goal, but it's only
intended for file systems.
But QCOW2 in general can be seen as a container or virtual disk node
containing various data.
Therefore, functionality like blkdev_reread_part for partition scanning
or fsck is needed, but it is not available in the user space. That
means, code must be translated and duplicated which is again not an
appropriate solution.

I have seen, that the tool vmware-mount for the VMDK file format is
based on fuse and supports all the mentioned block device functionality.
I was wondering how they achieved that but I don't want to know how much
code was duplicated.

If you have an idea to solve the opposition for file formats that are
acting as a container or virtual disk node for various data, please let
me know.

Regards,
Manuel

