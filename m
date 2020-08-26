Return-Path: <SRS0=3AMJ=CE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A589C433DF
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 18:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CF3D208E4
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 18:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCF6+VrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgHZS1n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:27:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32848 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727910AbgHZS0r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Aug 2020 14:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598466406;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jUC82NZTGG1NBiJnCc9uSJd7Fyro45VVAe7zgg+zWvA=;
        b=ZCF6+VrG5lHLY6j1vq+D289fESCHER6ckW1vAzK2RKiQ0vVuZbx+azZAThYZrEwXzjMdOG
        K1oUQ37cWLJ7Pno816G5zy36lIkeEHNR51v6/BcUA0xw97SLrbHxHMycrGhvJ+tIO64/bO
        8iOCfCsDB4AGyoB6PnzsoClrXeHFjpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-hKTNfgUyNBqTB2DSoUH00Q-1; Wed, 26 Aug 2020 14:26:42 -0400
X-MC-Unique: hKTNfgUyNBqTB2DSoUH00Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E83C6189E60D;
        Wed, 26 Aug 2020 18:26:39 +0000 (UTC)
Received: from [10.10.110.13] (unknown [10.10.110.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87162776E8;
        Wed, 26 Aug 2020 18:26:38 +0000 (UTC)
Reply-To: tasleson@redhat.com
Subject: Re: [v4 03/11] dev_vprintk_emit: Increase hdr size
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20200724171706.1550403-1-tasleson@redhat.com>
 <20200724171706.1550403-4-tasleson@redhat.com>
 <CAHp75VcwDhHmLbOO2WKkShNYAdLawLx6A5O-4newkCe4XEb3LQ@mail.gmail.com>
From:   Tony Asleson <tasleson@redhat.com>
Organization: Red Hat
Message-ID: <20dad8a0-9a6d-20b4-b5a1-06648c00008e@redhat.com>
Date:   Wed, 26 Aug 2020 13:26:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcwDhHmLbOO2WKkShNYAdLawLx6A5O-4newkCe4XEb3LQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/25/20 5:05 AM, Andy Shevchenko wrote:
> On Fri, Jul 24, 2020 at 8:19 PM Tony Asleson <tasleson@redhat.com> wrote:
> 
>> -       char hdr[128];
>> +       char hdr[288];
> 
> This is quite a drastic change for the stack.
> Can you refactor to avoid this?

The only thing I can think of is using a hash of the identifier instead
of the value itself.  This could drastically reduce the stack usage and
data stored in journal, but it makes it kind of clumsy for using.

Would placing this on the heap be acceptable?

