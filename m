Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22A0C7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 21:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbjDFVRM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjDFVRL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 17:17:11 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AC74C3A
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 14:17:11 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso6829479pjc.1
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 14:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680815830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDzKLZgQ4DLrPhYF71Ntb0jFiXzvjtbNYxt5vTB4n70=;
        b=pTxSLFOMoFUNlzaCLgr17hpiZiOqn4Us9gaTBSL58dL6EX3ngcmNecAu9fIhQ2F3Ka
         Ec8VcfXewqQrFPGTskIdm4U6HAXUP4eQF2FGTH1DxsRjY3vBKIHZF3t/48/KHszGw5EP
         +fYQjJYa6+tEtWDkeec7ZJXVbGYTj4Vz9NUGq5JsoLJW+Txni1n8n29wxHVH8szMaUwt
         Xyu5X68EPnP34Z+HHpFbS62CFjs0RMmRIr3jqMZc2+36CSPHqZRxy+/vXhjGNKqS59Po
         bZi5mIaaSUrStfPQZGCKqNeTnUsRWV+wrho3zEMfoRZ4uIAyfXbhgdydI2NskQIQ26UZ
         lgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680815830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDzKLZgQ4DLrPhYF71Ntb0jFiXzvjtbNYxt5vTB4n70=;
        b=p40S8D7BQR2gYxzKnHjxO1Zt7XnX39Z9hiTXLv6wDL3Pw61scfMAkN4vTODgosXgUG
         XDfPsAfb0a5n1LVRcXAUBwJ8Pztj17PIA+xYCV0wJhKniNMJ1Q7//gbM2pXOc8B+HC4t
         Tf4N4hb4DIVqH+W4U2SGyMyCQU6Al3Yr2VNkiZKm7M7XCjeyUKBqPsB93sm81k5FZzLO
         qVF9GPeYX575TGsPYEqqk+IvoQEdlTPL8ZfNR7Tq3yZ5g8ez0C1jjZSl6ZJ+TypuNNTA
         KT+AmoDTwicqQa/2c6B3iUreP9kJDoV39Vg0t+bVgDR6GYtKiQ9/oEpK1998Agsz6Rww
         WgRQ==
X-Gm-Message-State: AAQBX9fhg3UNa39qBXd07ny2h9ITgDkRUEgFzOcNJ9yijOdK7F6AjmPF
        sYtcc0yFiKvlPGnLEzy4iBw=
X-Google-Smtp-Source: AKy350ZHHEaGcGPZx6VMI5/WGaom6lhcziOtBxvgNyHiug9BNrI3AP3t+/APzlxdc1RncbL8LPhg1g==
X-Received: by 2002:a17:902:f291:b0:1a1:cc8b:7b0b with SMTP id k17-20020a170902f29100b001a1cc8b7b0bmr330066plc.66.1680815830600;
        Thu, 06 Apr 2023 14:17:10 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:6a8d:6a82:8d0e:6dc8])
        by smtp.gmail.com with ESMTPSA id f16-20020a170902ab9000b001a1d4a985eesm1761478plr.228.2023.04.06.14.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:17:09 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 6 Apr 2023 14:17:08 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 08/16] zram: rename __zram_bvec_read to zram_read_page
Message-ID: <ZC821Cgn+aG4Q0cQ@google.com>
References: <20230406144102.149231-1-hch@lst.de>
 <20230406144102.149231-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406144102.149231-9-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 06, 2023 at 04:40:54PM +0200, Christoph Hellwig wrote:
> __zram_bvec_read doesn't get passed a bvec, but always read a whole
> page.  Rename it to make the usage more clear.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
