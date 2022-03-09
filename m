Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09044C433EF
	for <linux-block@archiver.kernel.org>; Wed,  9 Mar 2022 01:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiCIBOZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 20:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiCIBOG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 20:14:06 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E6415DDF3
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 17:01:05 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id f8so871931pfj.5
        for <linux-block@vger.kernel.org>; Tue, 08 Mar 2022 17:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6ZZxOF1UZdYmWcsF+G4Cy++VZ4bnPtZUo2Vt4FjwtGI=;
        b=DQxbQK1fevCYyx0kq2IKm56w/874AbayfV9yVDuyiFJaIQ7K0/8V7lvVz5sxKW2Lkt
         dOBalK2O2h5Ngs0kz2JjR4XOlOWzP+XryVqlHCfOgZoJUTBSRsTvVeyLV9zugd2eUeIG
         kML7zgBRQAXUoy9KDOdGsWuwMzMDtktXbfdl8nwsLDGIouXRclNj4iV3xYgD8qJBCwMz
         1ukxg/sK8FyyZLHDMJ9tN9jE/75W63uClTM6GJeUuyZFzNFhcLSJAmIDrQY55Xp3VkGh
         ekqiwOQ6SRGD7CC6bsb2h1B4JqVHVNilB2qKqsdFCtcIA8YJISaBuu80h4umTlld/w2L
         +Xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6ZZxOF1UZdYmWcsF+G4Cy++VZ4bnPtZUo2Vt4FjwtGI=;
        b=W32auq+bruNQb/VGuZq+cFp5ir+Shzx8vFBM36IW1E9+53yUFrgaRXACG/Uai832MP
         xMEcXaBUi37E1/Vm/XafMQurufezbgL6xP8E/HCzHhWV1M136rDVa4JGdcZsqmzmzTEc
         DoSSjmiOHgiimqJxKuozaH2Xf6CVsatqbg55BFan8zix9XjRwRp9U8VEGf9ON80HkpBh
         KRlafEtZr3SIA03AqAPXyw+0/I9wDz9yWNEgbN92DFCCydreMjN5ss83epoy0zTboLHz
         EpeTC5LBNtLisfR/N8w5nB8iNZTwa4snvtmXQoM26LZ6AR08s/JKVL4YXwA2OOY1To3z
         J0lg==
X-Gm-Message-State: AOAM531Fo54I2lawSpaOlSBsOUOZBBHgPIiYERNlEoobPtOlOkB9LD3+
        iwgbH3mFWzObkbs9ZKY6OcZTRA==
X-Google-Smtp-Source: ABdhPJw8wYMUJ1TT+e5LCWPQcdeiQMTk8yoPMpHmtMfDIfhMY1+qfTodpbwOyZdHUV1wJnmVdVHYuw==
X-Received: by 2002:a05:6a00:bc8:b0:4f6:ff68:50ba with SMTP id x8-20020a056a000bc800b004f6ff6850bamr13433133pfu.69.1646787665250;
        Tue, 08 Mar 2022 17:01:05 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d20-20020a056a0010d400b004f7093700c4sm308968pfu.76.2022.03.08.17.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 17:01:04 -0800 (PST)
Message-ID: <70895fbc-392d-5ac6-4f7d-4593de5f74bb@kernel.dk>
Date:   Tue, 8 Mar 2022 18:01:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 1/2] block: add ->poll_bio to block_device_operations
Content-Language: en-US
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     ming.lei@redhat.com, hch@lst.de, dm-devel@redhat.com,
        linux-block@vger.kernel.org
References: <20220307185303.71201-1-snitzer@redhat.com>
 <20220307185303.71201-2-snitzer@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220307185303.71201-2-snitzer@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/7/22 11:53 AM, Mike Snitzer wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> Prepare for supporting IO polling for bio-based driver.
> 
> Add ->poll_bio callback so that bio-based driver can provide their own
> logic for polling bio.
> 
> Also fix ->submit_bio_bio typo in comment block above
> __submit_bio_noacct.

Assuming you want to take this through the dm tree:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

