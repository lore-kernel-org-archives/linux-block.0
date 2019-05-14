Return-Path: <SRS0=Dkg2=TO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425D0C04AB4
	for <linux-block@archiver.kernel.org>; Tue, 14 May 2019 14:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D10621473
	for <linux-block@archiver.kernel.org>; Tue, 14 May 2019 14:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfENO2r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 May 2019 10:28:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:59100 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbfENO2r (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 May 2019 10:28:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 47AB1AED5;
        Tue, 14 May 2019 14:28:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 14 May 2019 16:28:45 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Manuel Bentele <manuel-bentele@web.de>
Cc:     Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
        linux-block-owner@vger.kernel.org
Subject: Re: Adding QCOW2 reading/writing support
In-Reply-To: <762bceb9-c66c-0a45-7d6b-e5ed0df56cbf@web.de>
References: <60bbe5e0-317d-8ead-0eb8-d1dc79927bc8@web.de>
 <c6b31507-bb02-c886-aea6-4165606f215d@suse.de>
 <762bceb9-c66c-0a45-7d6b-e5ed0df56cbf@web.de>
Message-ID: <7a74dd35a390df25f2874aa7b4f8547e@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019-04-17 23:53, Manuel Bentele wrote:

[cut]

> If you have an idea to solve the opposition for file formats that are
> acting as a container or virtual disk node for various data, please let
> me know.

If you need a raw block device you can export qcow2 image as a network 
block
device, something as the following:

# modprobe nbd
# qemu-nbd --connect=/dev/nbd0 image.qcow2
# fdisk -l /dev/nbd0

I suppose simplest variant.

--
Roman

