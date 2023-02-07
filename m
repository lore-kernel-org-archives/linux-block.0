Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB81EC636CD
	for <linux-block@archiver.kernel.org>; Tue,  7 Feb 2023 14:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjBGOJM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Feb 2023 09:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjBGOJL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 09:09:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED96C30FC
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 06:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675778902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QEzLx8f/Jh0Mqzqio9inDdt+8TpOIRn8LBYwXeHh+ZY=;
        b=G8MJRznxozBfTZgE1TcVhMCwAaIsuI5ijhptXDegehhqhTruWxXS5S+mHlqPLl4uMSbUTx
        s+MS5U7E1i9EdHCIDu9QckNkjcYjP53kHZxqclE2YkL+HHCxMwsTXZi33j2AKJibUIM7B6
        w3tyvtjfHBRJnNmBBFTdrCQ5LqKSuSg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-9i3_IsqHOD-fVrkLf1-Ixw-1; Tue, 07 Feb 2023 09:08:19 -0500
X-MC-Unique: 9i3_IsqHOD-fVrkLf1-Ixw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61CB33C10682;
        Tue,  7 Feb 2023 14:08:18 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C935E400DFDB;
        Tue,  7 Feb 2023 14:08:14 +0000 (UTC)
Date:   Tue, 7 Feb 2023 22:08:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH RESEND 3/3] ublk: pass NULL to blk_mq_alloc_disk() as
 queuedata
Message-ID: <Y+JbSXbapJtHP/cY@T590>
References: <20230207070839.370817-1-ZiyangZhang@linux.alibaba.com>
 <20230207070839.370817-4-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207070839.370817-4-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 07, 2023 at 03:08:39PM +0800, Ziyang Zhang wrote:
> queuedata is not referenced in ublk_drv and we can use driver_data
> instead. Pass NULL to blk_mq_alloc_disk() as queuedata while allocating
> ublk's gendisk.
> 
> Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks, 
Ming

