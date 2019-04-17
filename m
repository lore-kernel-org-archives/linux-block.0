Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4B9C282DA
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 11:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F56D206BA
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 11:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbfDQL6h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:58:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:44474 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731454AbfDQL6g (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Apr 2019 07:58:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CDC12ABE9;
        Wed, 17 Apr 2019 11:58:35 +0000 (UTC)
Subject: Re: Adding QCOW2 reading/writing support
To:     Manuel Bentele <manuel-bentele@web.de>, linux-block@vger.kernel.org
References: <60bbe5e0-317d-8ead-0eb8-d1dc79927bc8@web.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <c6b31507-bb02-c886-aea6-4165606f215d@suse.de>
Date:   Wed, 17 Apr 2019 13:58:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <60bbe5e0-317d-8ead-0eb8-d1dc79927bc8@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/16/19 11:30 PM, Manuel Bentele wrote:
> Hi everyone
> 
> I'm going to implement an in-kernel reading of QCOW2 images.
> In the project, I only need the reading of QCOW2 images, but it's
> essential to make thoughts for the implementation of the writing, too.
> One of the difficulties seems to be the support of making an image
> sparse (resizing the disk image).
> 
> Now, I want to ask you for advice: What is the best approach to achieve
> this?
> 
>    * Implement the reading/writing in the device mapper?
>    * Extend the loop device?
>    * Create a new subsystem for the processing of sparse devices or images?
> 
> Or do you have any other idea?
> 
I'm not sure if that would be met with universal acclaim; file formats 
are regarded as userland policies, and shouldn't be handled in the 
kernel at all.
Have you looked at fuse?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
