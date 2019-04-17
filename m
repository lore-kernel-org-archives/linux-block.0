Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1950C282DA
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 12:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95182173C
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 12:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbfDQMQv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:16:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:47390 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731499AbfDQMQv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Apr 2019 08:16:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9FAA5B031;
        Wed, 17 Apr 2019 12:16:50 +0000 (UTC)
Subject: Re: Adding QCOW2 reading/writing support
To:     Manuel Bentele <manuel-bentele@web.de>,
        Ming Lei <tom.leiming@gmail.com>
Cc:     linux-block <linux-block@vger.kernel.org>
References: <60bbe5e0-317d-8ead-0eb8-d1dc79927bc8@web.de>
 <CACVXFVPKHUgbgsbFZSDWqF7GTPyBzKJjKCSq7EYygre_GvpbyQ@mail.gmail.com>
 <2fbeba35-38f3-22cf-a4d5-49f8af5e6802@web.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <39218225-a402-fb3a-dbc6-db2d95e51bd3@suse.de>
Date:   Wed, 17 Apr 2019 14:16:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <2fbeba35-38f3-22cf-a4d5-49f8af5e6802@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/17/19 1:32 PM, Manuel Bentele wrote:
> Hi,
> 
> On 17.04.19 03:35, Ming Lei wrote:
>> Hi,
>>
>> On Wed, Apr 17, 2019 at 5:33 AM Manuel Bentele <manuel-bentele@web.de> wrote:
>>> Hi everyone
>>>
>>> I'm going to implement an in-kernel reading of QCOW2 images.
>>> In the project, I only need the reading of QCOW2 images, but it's
>>> essential to make thoughts for the implementation of the writing, too.
>>> One of the difficulties seems to be the support of making an image
>>> sparse (resizing the disk image).
>> Could you describe this requirement in a bit more detail? Especially why
>> do you want to read/write QCOW2 in kernel?
> 
> Yes, of course. The implementation of reading a QCOW2 disk image
> in-kernel is required for an already existing system in the university
> environment.
> At the moment, the Linux kernel, initramfs, etc. for each client in the
> system is loaded via PXE boot and then the block device with the default
> file system is included with the help of a modified nbd version, called
> dnbd (distributed nbd).
> Due to the fact that the data on the default file system is only for non
> persistent one-time provision of a client, read access is sufficient.
> The user related data is stored on a network storage, as mostly done in
> large scale infrastructures.
> 
> Now, the goal is to minimize the network usage and avoid nbd.
> Furthermore, fixed configured and packed boot images should be avoided.
> Therefore, the advantage of the sparse and compression functionality of
> QCOW2 should be used.
> A workaround for that problem could be the local usage of nbd to include
> the QCOW2 disk image as block device, but it involves a lot of
> interaction between user and kernel space and thus an decreasing
> performance. That leads to the motivation to implement the reading of
> QCOW2 disk images directly in the kernel and aim for an merge into the
> mainline kernel source to avoid out-of-kernel-tree maintenance.
> 
> If you have any questions related to the described use case or if you
> require more information, please let me know.
> Thanks for your help.
> 
cramfs?
Or btrfs with compression enabled?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
