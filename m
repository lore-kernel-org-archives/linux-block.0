Return-Path: <SRS0=Dgp+=T4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ED6C04AB6
	for <linux-block@archiver.kernel.org>; Tue, 28 May 2019 16:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA592166E
	for <linux-block@archiver.kernel.org>; Tue, 28 May 2019 16:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfE1Qga (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 May 2019 12:36:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfE1Qg3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 May 2019 12:36:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9D27630C1328;
        Tue, 28 May 2019 16:36:24 +0000 (UTC)
Received: from [10.10.126.56] (ovpn-126-56.rdu2.redhat.com [10.10.126.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 549375D6A9;
        Tue, 28 May 2019 16:36:22 +0000 (UTC)
Subject: Re: [PATCH 2/3] nbd: notify userland even if nbd has already
 disconnected
To:     Yao Liu <yotta.liu@ucloud.cn>, Josef Bacik <josef@toxicpanda.com>
References: <1558691036-16281-1-git-send-email-yotta.liu@ucloud.cn>
 <1558691036-16281-2-git-send-email-yotta.liu@ucloud.cn>
 <20190524130856.zod5agp7hk74pcnr@MacBook-Pro-91.local.dhcp.thefacebook.com>
 <20190527182323.GB20702@192-168-150-246.7~>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5CED6385.3000802@redhat.com>
Date:   Tue, 28 May 2019 11:36:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190527182323.GB20702@192-168-150-246.7~>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 28 May 2019 16:36:29 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05/27/2019 01:23 PM, Yao Liu wrote:
> On Fri, May 24, 2019 at 09:08:58AM -0400, Josef Bacik wrote:
>> On Fri, May 24, 2019 at 05:43:55PM +0800, Yao Liu wrote:
>>> Some nbd client implementations have a userland's daemon, so we should
>>> inform client daemon to clean up and exit.
>>>
>>> Signed-off-by: Yao Liu <yotta.liu@ucloud.cn>
>>
>> Except the nbd_disconnected() check is for the case that the client told us
>> specifically to disconnect, so we don't want to send the notification to
>> re-connect because we've already been told we want to tear everything down.
>> Nack to this as well.  Thanks,
>>
>> Josef
>>
> 
> But in userland, client daemon process and process which send disconnect
> command are not same process, so they are not clear to each other, so
> client daemon expect driver inform it to exit.
> In addition, client daemon will get nbd status with nbd_genl_status interface
> after it get notified and it should not re-connect if status connected == 0
> 

When using the netlink interface you get the NBD_CMD_LINK_DEAD first
then the configs_refs goes to zero right?

nbd_disconnect_and_put -> sock_shutdown -> nbd_mark_nsock_dead

then later we do the final nbd_config_put?

Maybe it would be best to add a new netlink event to signal what has
happened, because the above nl and stat algorithm seems like a pain. The
NBD_CMD_LINK_DEAD will be sent, then userspace has to possibly poll the
status to check if this was caused due to nbd_genl_disconnect instead of
a downed link due to something like a command timeout, because the
refcount may not be down when userspace gets the NL event.

Or, I guess the admin/tool process could just send a msg to the daemon
process to tell it to do the netlink disconnect request.
