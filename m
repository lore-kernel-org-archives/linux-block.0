Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB62C282DA
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 21:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626092183E
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 21:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="YigHpAy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfDQVEg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:04:36 -0400
Received: from mout.web.de ([212.227.15.4]:43867 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbfDQVEg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Apr 2019 17:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1555535071;
        bh=sBRgnhfecbuf82KQZNLyXO3dpBDg24snYH5r9/nq6e8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YigHpAy3YEGM3INSHwyn4rNzg03Jwgu2o0vtweRGKWPUUQDJJvRbijn8GyGutNnES
         NWm+PsDLoxJHe9KtHpPFKckb8syPNAr8dI9qs9UQGtif8HcKrK3O5q4rR9nN/uJRe5
         O934dh2VnO0ha0bi/OB6OwFVQCbEena5GyQd5OlY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from laptop.manuel.cli.intranet ([109.192.218.194]) by smtp.web.de
 (mrweb003 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LecN4-1gUu813Y9W-00qS2C; Wed, 17 Apr 2019 23:04:31 +0200
Subject: Re: Adding QCOW2 reading/writing support
To:     Hannes Reinecke <hare@suse.de>, Ming Lei <tom.leiming@gmail.com>
Cc:     linux-block <linux-block@vger.kernel.org>
References: <60bbe5e0-317d-8ead-0eb8-d1dc79927bc8@web.de>
 <CACVXFVPKHUgbgsbFZSDWqF7GTPyBzKJjKCSq7EYygre_GvpbyQ@mail.gmail.com>
 <2fbeba35-38f3-22cf-a4d5-49f8af5e6802@web.de>
 <39218225-a402-fb3a-dbc6-db2d95e51bd3@suse.de>
From:   Manuel Bentele <manuel-bentele@web.de>
Openpgp: id=5260D26DAE5C7FDF3113C572EC7CB9F864CA371E
Autocrypt: addr=manuel-bentele@web.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7a49ec14-5f46-1b7c-3311-83fdaa5b1761@web.de>
Date:   Wed, 17 Apr 2019 23:04:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <39218225-a402-fb3a-dbc6-db2d95e51bd3@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
X-Provags-ID: V03:K1:ofEWQpL8jI3mGohZYyuO2YUTqNoTBPOQMQqgwnUtyA/HOq7VWxd
 qiOl9CgJ/Wf1EmTROhMTKCzw4zdSm5UUmfe3HdJ7aWtjYjZz/yuWax2TlUpX0Ux8GiubrZf
 QKSJioNW34upVjFoNpBDRO7P+atcqS4WE0jRVIAELHAWIZO3QUjn0DjorlWuENAmfmRD513
 kBlqeTrU5KdtPfvaW0BKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yH5c/f8eYhM=:KqPbHc2WkUNMxFXflLhzWW
 AQKL23CpPLIyuOTWuVYGANpu2x4DdYcu4aQ3cD7te3xvOxSH7z7m3kFo7Et5mRxl/qAj/l3qm
 fBacHrhFO9EPnhQkPSLB+YYVl1M8P/Hf0loAqehVXIz2TfZRpWSi0vKibNq9fkUpvPTCqNDei
 r6S7T03vC6ohYyIi9VSDykpgME8uG8qz0YHuK6c83Xzjh90lRefyPqSYG572yeZksfVdHPbrT
 O7KXavHCJt+NaB4aE/KPXjuu+5iH3xokmLUm2WDFRfNZBsP2r3TTbnqO9+J25DFKhTzInQmgW
 wtTH3wdgDBfwdGvbb7iwLSczTK1vmI7D003IDLhGjc1VOADUKCFjLutktvwKWtiMYQrIcv+JH
 W6Zu5ZMqzNHY4tZPdXgUuX1UjrHteRt8LcNfK9yg6WKrGVBKKmkgXqGD+O3SFl92BWl9WyxDt
 W+uSUctA9zPIQi3MAxw1oh/XaxOrJm2a072Qszd78Ix1gyIQsWMiLi9vrpeEaLMW00FIBm2q6
 e0VgyYa4AyZmfIkMoFf/PVjUJ897Wp5le6lJlulvDTfqAOmpBXDekUpll8fUwrmeC7WLg2eTJ
 nHvoc2lhO20+8zh6rYDpVHEXoQRul4Yk2Inkm/Kv7JAm8NWPXkFnJTllGQ9TViAJhJJTh1j7w
 Uydm4wm5rC50sWLeksiaEX+SvVhEpUZSGjRdt6gxT7OmPCPepr5avJmt6/EwbbV7bqR/d2i5o
 tVZ+pv6wYG9VjCKLZx/D6Fd98BzdOSOHRywVnEUhVwSEl620tyCgldueqV50d2kPh/Sm94BsI
 mXY12G3oiuaIfV68UZtn6kj5KwSkJZAxyXm2MWc/b9m/3vMOrpNBtBVO4GJkLA5f2hdJo4rz1
 F/1vto+dXcT/kE4uBbn1y4RzdrvO/I5o9Q4VLg7uDDycAxXkeBURaPX7bL+buMrj9syqtIMhN
 M8qQGp1WdsQ==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 17.04.19 14:16, Hannes Reinecke wrote:
> On 4/17/19 1:32 PM, Manuel Bentele wrote:
>> Hi,
>>
>> On 17.04.19 03:35, Ming Lei wrote:
>>> Hi,
>>>
>>> On Wed, Apr 17, 2019 at 5:33 AM Manuel Bentele
>>> <manuel-bentele@web.de> wrote:
>>>> Hi everyone
>>>>
>>>> I'm going to implement an in-kernel reading of QCOW2 images.
>>>> In the project, I only need the reading of QCOW2 images, but it's
>>>> essential to make thoughts for the implementation of the writing, too.
>>>> One of the difficulties seems to be the support of making an image
>>>> sparse (resizing the disk image).
>>> Could you describe this requirement in a bit more detail? Especially
>>> why
>>> do you want to read/write QCOW2 in kernel?
>>
>> Yes, of course. The implementation of reading a QCOW2 disk image
>> in-kernel is required for an already existing system in the university
>> environment.
>> At the moment, the Linux kernel, initramfs, etc. for each client in the
>> system is loaded via PXE boot and then the block device with the default
>> file system is included with the help of a modified nbd version, called
>> dnbd (distributed nbd).
>> Due to the fact that the data on the default file system is only for non
>> persistent one-time provision of a client, read access is sufficient.
>> The user related data is stored on a network storage, as mostly done in
>> large scale infrastructures.
>>
>> Now, the goal is to minimize the network usage and avoid nbd.
>> Furthermore, fixed configured and packed boot images should be avoided.
>> Therefore, the advantage of the sparse and compression functionality of
>> QCOW2 should be used.
>> A workaround for that problem could be the local usage of nbd to include
>> the QCOW2 disk image as block device, but it involves a lot of
>> interaction between user and kernel space and thus an decreasing
>> performance. That leads to the motivation to implement the reading of
>> QCOW2 disk images directly in the kernel and aim for an merge into the
>> mainline kernel source to avoid out-of-kernel-tree maintenance.
>>
>> If you have any questions related to the described use case or if you
>> require more information, please let me know.
>> Thanks for your help.
>>
> cramfs?
> Or btrfs with compression enabled?
>
> Cheers,
>
> Hannes

Thanks for your simple idea to choose cramfs or btrfs with compression
enabled.
I will suggest that as alternative at the next project meeting.

Regards,
Manuel
