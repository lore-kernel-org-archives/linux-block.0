Return-Path: <SRS0=Dkg2=TO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A887C04AB4
	for <linux-block@archiver.kernel.org>; Tue, 14 May 2019 08:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D7120879
	for <linux-block@archiver.kernel.org>; Tue, 14 May 2019 08:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="U7OlcISL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbfENI5A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 May 2019 04:57:00 -0400
Received: from mout.web.de ([217.72.192.78]:36065 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfENI5A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 May 2019 04:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557824212;
        bh=zQ0L6kjDfDkunnMdQh3TBI5ueC6j8Z+nEDnY8o8UAHw=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=U7OlcISLxoWIdx7bTdk+jKGVi7SZ3ZYwZEIpNDH3Hkyyb4rrJVyP+FrXD4TlIjuLF
         dLCTYWxjbDMjE87FhgPb1ebhJUT4IMr4T24zbtKKRIx60P6FSG9v+htNzHFSkrkgMy
         D3NRSltjGZHEZHaqTg5jRCSK7Y6uXMwVno3Jfh48=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [10.1.1.111] ([109.192.195.138]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MSrYf-1hJ9dZ0he9-00Rrk2; Tue, 14
 May 2019 10:56:52 +0200
Subject: Re: Adding QCOW2 reading/writing support
From:   Manuel Bentele <manuel-bentele@web.de>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        linux-block <linux-block@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <60bbe5e0-317d-8ead-0eb8-d1dc79927bc8@web.de>
 <CACVXFVPKHUgbgsbFZSDWqF7GTPyBzKJjKCSq7EYygre_GvpbyQ@mail.gmail.com>
 <2fbeba35-38f3-22cf-a4d5-49f8af5e6802@web.de>
 <39218225-a402-fb3a-dbc6-db2d95e51bd3@suse.de>
 <7a49ec14-5f46-1b7c-3311-83fdaa5b1761@web.de>
 <CACVXFVNU_+rX2XA+t+Ac+Wu_+n3u=aWmk0rDhj7zJv9x7iP8pQ@mail.gmail.com>
 <1352c7de-b57d-2042-8bba-5a7a544390b8@web.de>
Message-ID: <30d73468-a117-86a5-d38a-48f79546e5ee@web.de>
Date:   Tue, 14 May 2019 10:56:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1352c7de-b57d-2042-8bba-5a7a544390b8@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:FGYq576GTESF1qpQWNMOnbm3xINZAwRV68Gq95Lm3O3tpPCAell
 g7vB5q5GVN1hWkLiXv2Jtz8/YGIzSpJTyI/yyfmvnmDx5esPxMSbg2pHxhjso6wgfaiAzT9
 VoP6saszu8knhO+ZTnEur3xqn+MSxyiAIQMH8kxcxZCQ6cftXYKHMjd5rkNjP50ToXWZ65+
 YsCTFHCMLAonlieY5ly9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5Jl00wbqJ5g=:+N/pMW1yLRkefTkQ/zo8ui
 HoYWN2J2gTD3PukrlpvvpAPWBhJuJurVf8xQF+EX+5l7pln5IMAUhgieO93Vq5QyiTpok1bf0
 8/+EyUH5g8HPOhO1IeVzPHsG7Eoa8cVHgt4LgP+8jGKnU3pkb3CsSltylgAfnEvbs6CO2iARV
 ZZv7Q4Bm90mf6H5P4foHeq1fyyCnCG5hhmDIUloKngJSC1gtIHhFc8A9xIrQcQz5xnqq/EJSV
 RuSOPTTkieI3HYH8DGR7F8Zh6O+Z9k757uYLpxApbUPEHLRMnf46bbTobME2ckxzrGKEi3sav
 QmKyzPLcmBtfWG1Zj0BN+i3R6TrnXqDbutt444UfhukMQRLDGWh0MwHHxa24LANfNBZJ+xAWZ
 CjLbwCCmWED82Xz8SBpdOWGMT3Hga65losLNkj1ijJOGdxuSble+/FJ2qM+ZoROjYX7mMamkT
 aPPV7zew+o8qY71YxFKKbRX/FFy9WJa+KEAB+b640tWQ6XqZE1c3jYQU9qgOVGfaTdXDGV3OY
 DetwS3t/c91UJNcr9mlut6wNp5pmNlm9JwY+ggvD4aC6sTDcfIguAQ42SlDwOnROz8cuMM3CC
 5sGT7fjsOxLlppQ7ejJQJV5OjcHnA1RAMArwAiTx0AgwPszRn7vjnhnAAWnnbhp01XgoXbbsb
 JJAYYstcbZpje5Sw5SrQlLy1Pc7Nm1WUuAFtjGoeRs1GZUpmRbYT9dBDFd1dU6vA0fa4eHifI
 abP7krxyfRL3aReO0nl9Poz2q4D2yQCwIaa4QDEY3Q2kO0wtJOeNGTLMfQ5ACRX1MbjkpkxSn
 3xkYuWHgNJ5zUpIGbssfesQEMA7lAhXQ36aup+XnfXeEGVPZLIHOuksqtSd/ZBMfffepRT1yq
 TO9sFHNB6PwLY3xTJbborHICteoQvXM7XA1MmuQIcyOfu+cuYXlMNbRc0L0nGKmmUlvJh0fnH
 k4rMAECP5JQ==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi

On 4/18/19 12:02 PM, Manuel Bentele wrote:
> On 18.04.19 03:05, Ming Lei wrote:
>> On Thu, Apr 18, 2019 at 5:04 AM Manuel Bentele <manuel-bentele@web.de> wrote:
>>> On 17.04.19 14:16, Hannes Reinecke wrote:
>>>> On 4/17/19 1:32 PM, Manuel Bentele wrote:
>>>>> Hi,
>>>>>
>>>>> On 17.04.19 03:35, Ming Lei wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Wed, Apr 17, 2019 at 5:33 AM Manuel Bentele
>>>>>> <manuel-bentele@web.de> wrote:
>>>>>>> Hi everyone
>>>>>>>
>>>>>>> I'm going to implement an in-kernel reading of QCOW2 images.
>>>>>>> In the project, I only need the reading of QCOW2 images, but it's
>>>>>>> essential to make thoughts for the implementation of the writing, too.
>>>>>>> One of the difficulties seems to be the support of making an image
>>>>>>> sparse (resizing the disk image).
>>>>>> Could you describe this requirement in a bit more detail? Especially
>>>>>> why
>>>>>> do you want to read/write QCOW2 in kernel?
>>>>> Yes, of course. The implementation of reading a QCOW2 disk image
>>>>> in-kernel is required for an already existing system in the university
>>>>> environment.
>>>>> At the moment, the Linux kernel, initramfs, etc. for each client in the
>>>>> system is loaded via PXE boot and then the block device with the default
>>>>> file system is included with the help of a modified nbd version, called
>>>>> dnbd (distributed nbd).
>>>>> Due to the fact that the data on the default file system is only for non
>>>>> persistent one-time provision of a client, read access is sufficient.
>>>>> The user related data is stored on a network storage, as mostly done in
>>>>> large scale infrastructures.
>>>>>
>>>>> Now, the goal is to minimize the network usage and avoid nbd.
>>>>> Furthermore, fixed configured and packed boot images should be avoided.
>>>>> Therefore, the advantage of the sparse and compression functionality of
>>>>> QCOW2 should be used.
>>>>> A workaround for that problem could be the local usage of nbd to include
>>>>> the QCOW2 disk image as block device, but it involves a lot of
>>>>> interaction between user and kernel space and thus an decreasing
>>>>> performance. That leads to the motivation to implement the reading of
>>>>> QCOW2 disk images directly in the kernel and aim for an merge into the
>>>>> mainline kernel source to avoid out-of-kernel-tree maintenance.
>>>>>
>>>>> If you have any questions related to the described use case or if you
>>>>> require more information, please let me know.
>>>>> Thanks for your help.
>>>>>
>>>> cramfs?
>>>> Or btrfs with compression enabled?
>>>>
>>>> Cheers,
>>>>
>>>> Hannes
>>> Thanks for your simple idea to choose cramfs or btrfs with compression
>>> enabled.
>>> I will suggest that as alternative at the next project meeting.
>> Or vdo which provides compression in block device level:
>>
>> https://github.com/dm-vdo/vdo
> Thanks for your hint. I will take a look at it.

I suggested all your ideas at the project meeting. The meeting revealed
that most of the people want to hold on the QCOW2 container format and
want to avoid the 'stacking' of other solutions.
In addition to that, FUSE should not be used due to performance reasons.

All in all, that leads to the plan to extend the existing loop device
driver to support not only raw binary files, but also the QCOW2
container format. If there exists a usable and clean solution at the
end, I will inform you and propose it for a review.

Thanks for your help.

Regards,
Manuel
<mailto:manuel-bentele@web.de>
