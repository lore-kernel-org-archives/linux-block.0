Return-Path: <SRS0=NI9l=Y6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2A0C5DF62
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 12:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A5C21848
	for <linux-block@archiver.kernel.org>; Wed,  6 Nov 2019 12:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQAVOZAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfKFMz0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Nov 2019 07:55:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44273 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728140AbfKFMz0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Nov 2019 07:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573044925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8PJdBWwQBLSLtcUQy+9zKMbCYQP7SYoOr1q4q0d5OCc=;
        b=OQAVOZAM+OO8r+vJUnSQbMMOrRqX6G+HIF5shhWP9oOAyWBClsdSq1Rf0SAfUCU+AJoN6H
        6hPrLpcFCbi1a8bQU3YdCkfg8O4yvy9ziXPsp/vDRZF0m8SBwU9/J/a+xN6ug1wS9Iot08
        nqap/jEDN89VqqJBif967P5ichZG8zk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-sl0KgZnxNLW9IYq1JSM7Xg-1; Wed, 06 Nov 2019 07:55:23 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 995FC107ACC3;
        Wed,  6 Nov 2019 12:55:22 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (unknown [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 013D71001B35;
        Wed,  6 Nov 2019 12:55:21 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, mgorman@suse.de, hare@suse.de,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: elevator= kernel argument for recent kernels
References: <20191106105340.GE16085@quack2.suse.cz>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Wed, 06 Nov 2019 07:55:20 -0500
In-Reply-To: <20191106105340.GE16085@quack2.suse.cz> (Jan Kara's message of
        "Wed, 6 Nov 2019 11:53:40 +0100")
Message-ID: <x49h83hnozr.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: sl0KgZnxNLW9IYq1JSM7Xg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

> Hello,
>
> with transition to blk-mq, the elevator=3D kernel argument was removed. I
> understand the reasons for its removal but still I think this may come as=
 a
> surprise to some users since that argument has been there for ages and
> although distributions generally transition to setting appropriate elevat=
or
> by udev rules, there are still people that use that argument with older
> kernels and there are quite a few advices on the Internet to use it. So
> shouldn't we at least warn loudly if someone uses elevator=3D argument on
> kernels that don't support it and redirect people to sysfs? Something lik=
e
> the attached patch? What do people think?

That's fine with me.

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

