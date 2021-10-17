Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90466C433EF
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 723636115C
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241377AbhJQBRH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 21:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhJQBRG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 21:17:06 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F386FC061765
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:14:57 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id x1so11213981ilv.4
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xi5ckIaoMENm5Tp7gp+F7aG+6wj62o5cxejj8EPGIPE=;
        b=L1I7qGCnv3dDDbg6LPwElloKYxEDDwxlzlKoSfiYhfE584sJsNs/4MP61W9/l7O5lF
         gcLrxQvE+t0AhHU0CXTVizIdA2n7YmJ3mKN1MRwpGaXxVn2m7bCgLCBH5WZ3Ob1xK1vi
         AL9pMbFAhp82ldn/hhVMqu2xOfDLqqs9v5fxS4E8ESwiSXfSZhkNb2c4ALu/U9ihe172
         hR1MNWrEx84OP4SCd+oE/sKoQCzVGFcFxiBXXwIthBYtlQinDtONRxG3Kjn+jj8W6veR
         yu4p9aYpZq9xF/FDu9Su2xotXlYNegETmEe+bqo9PspQFP70usXK0RFHCKh2soo4jsd/
         g5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xi5ckIaoMENm5Tp7gp+F7aG+6wj62o5cxejj8EPGIPE=;
        b=NaWfBEnaRo//0Oei9AFWNhNXJQu5EUYlyWHGlosCjAO98v8grTOthI19IN/7gda++e
         TrPdBoc+9O6PJvTJKOpiv17EIvzZoK5SZUW269L+05Y60Sx8JD8WVgZEvxHm+YfNsAx0
         HzTOqSA3iyqwQISefEucMVlS2pzsYSr4QEj4wVfLW6lLrxuLQ1OFcWL57zuBDxenz5Ub
         AD+kawzhhwo9R722Z/ye3bhIGpzVvMkf6IFkGxIyUWzLG8NJ/95Y53vUp6QI+Fv1cKct
         w9BMdoKEX7G831P3RpfX1lLQxd/G8aDJx5zDz9m0XhfhUcACuALJ/kwrngDj6F+Z5RfF
         P1GA==
X-Gm-Message-State: AOAM533bo36HC3EBO6xyoG2b7EOBsUE6ePyGD+UiaHvViKmOtOuwE9pW
        86XB95FJzBlinJYCDDDNq2Xm+53vhjlVVQ==
X-Google-Smtp-Source: ABdhPJycqY0fcSw+iQHBnt+vnvarmVRFAnZr5sp/0sMCYhjSDhu4kD9+su8rdNcq6u2eVjBYMHjtWQ==
X-Received: by 2002:a05:6e02:1b81:: with SMTP id h1mr8837369ili.240.1634433297358;
        Sat, 16 Oct 2021 18:14:57 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id y6sm5066841ilv.57.2021.10.16.18.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Oct 2021 18:14:57 -0700 (PDT)
Subject: Re: tear down file system I/O in del_gendisk v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20210929071241.934472-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ed7bee0e-fcec-e32d-6374-50810232c179@kernel.dk>
Date:   Sat, 16 Oct 2021 19:14:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210929071241.934472-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/29/21 1:12 AM, Christoph Hellwig wrote:
> Ming reported that for SCSI we have a lifetime problem now that
> the BDI moved from the request_queue to the disk as del_gendisk
> doesn't finish all outstanding file system I/O.  It turns out
> this actually is an older problem, although the case where it could
> be hit before was very unusual (unbinding of a SCSI upper driver
> while the scsi_device stays around).  This series fixes this by
> draining all I/O in del_gendisk.
> 
> Changes since v2:
>  - move the call to submit_bio_checks into freeze protection
> 
> Changes since v1:
>  - fix a commit log typo
>  - keep the existing nowait vs queue dying semantics in bio_queue_enter 
>  - actually keep q_usage_counter in atomic mode after del_gendisk

Looks like there's no other way than going down this path, even though
it's not the most exciting right now... I have applied this one for
5.15.

-- 
Jens Axboe

