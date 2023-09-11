Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97102CA0ED8
	for <linux-block@archiver.kernel.org>; Mon, 11 Sep 2023 21:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350823AbjIKVlg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237861AbjIKNQD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Sep 2023 09:16:03 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04722EB
        for <linux-block@vger.kernel.org>; Mon, 11 Sep 2023 06:15:59 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c3c4eafe95so772455ad.1
        for <linux-block@vger.kernel.org>; Mon, 11 Sep 2023 06:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694438158; x=1695042958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=23rqbeU88G+H/X4YiesJiBFthRxmZeNP6+NeVuIKyqQ=;
        b=doHL6hyQ/V7Y9snH2y1MrcixHhXL2WMgXtKDtw1BXpJzhdW4N9nOs9GjGm7zTh1Xv1
         c46XkQj3a+arU5K0NcyUBQlvcSf/keUYQlXe+1/4T6xEOEqHjoScGOALZ24WlTNUvtR1
         S0c5/lt/8mCYa+4W2YPeje2frPXsy0B/t7pSW8Uy15Wh0eMbQ1cAjmnLwlRXgFd5WOGN
         DpZUOFzXL4QBUs0OWLKizcXM/LSSshqhAUztzqdmbS628vBRgBP2iIjNA5MWX7lYesSE
         NEjsI9JT3RJXi16WW8grOvq3Xs1epIf2w9rPB1gPSyQswbpbdrnuepKf3IHa20g6xwRr
         OF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694438158; x=1695042958;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23rqbeU88G+H/X4YiesJiBFthRxmZeNP6+NeVuIKyqQ=;
        b=pjuCvyPSly9L19bXrXB0hu/2IeSAmEkur6vdjCjh4oxgjEmA831cl7d9MLvpyHPym+
         U5D7ihh3shnbIAMQ6zNmHuKRLhNgBtwb+fGo7Hz7BHVil54aCT6p+3dlL6/5E/KzelX+
         wbcxWZk/fTFlE7U15x1PEzZM4suKsY0fKifNf04xIHgnC3dgYmzsiPFxwzTHYTYudMSB
         8nN3Dm6p8uVVR4DmBaXLxNjqKyvxBLLEAWpwQy09shjz/v4sbReZepYRjMjbS8pkBUVS
         j7auU0Q/YdBxMb02ktPuDXMFlwXpwCwXBiG9bpPoN1gMGRqpyu8cdRSsX8p29vhasz+5
         2EUg==
X-Gm-Message-State: AOJu0Yzy0eEW90QP7/cXwdVopMU+LdyIkEH0Kl7wpxq9FTcCHruwwen0
        R03ROYuAtY6P9paNas70/oh1uw==
X-Google-Smtp-Source: AGHT+IEW/qPX2aarnJBsg+oN5jjbtYswhOeCTZgT6Y//Ff+leWEMuq7sKChCh7hLURN4RxMDM7Af4A==
X-Received: by 2002:a17:902:d4c3:b0:1c3:411c:9b98 with SMTP id o3-20020a170902d4c300b001c3411c9b98mr11537309plg.3.1694438158433;
        Mon, 11 Sep 2023 06:15:58 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f12-20020a17090274cc00b001bbb22652a4sm6365069plt.226.2023.09.11.06.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 06:15:57 -0700 (PDT)
Message-ID: <f646a624-224c-4dde-97e9-78333a1f79a8@kernel.dk>
Date:   Mon, 11 Sep 2023 07:15:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [block?] WARNING in floppy_check_events (2)
Content-Language: en-US
To:     syzbot <syzbot+2302c7d7bfcdb6baae34@syzkaller.appspotmail.com>,
        efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000004b06a9060510505d@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0000000000004b06a9060510505d@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

https://lore.kernel.org/all/7df3e30a-aa31-495c-9d59-cb6080364f61@kernel.dk/

-- 
Jens Axboe
