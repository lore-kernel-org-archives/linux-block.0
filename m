Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390EBC25B48
	for <linux-block@archiver.kernel.org>; Fri, 27 Oct 2023 19:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjJ0TyE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Oct 2023 15:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjJ0TyE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Oct 2023 15:54:04 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3CA1B1
        for <linux-block@vger.kernel.org>; Fri, 27 Oct 2023 12:54:01 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-27fe16e8e02so417057a91.0
        for <linux-block@vger.kernel.org>; Fri, 27 Oct 2023 12:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1698436441; x=1699041241; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BstzjcyRw76SGnx2Oi2IF7IWdWUB4/PFTixP0/vCToE=;
        b=uwzJ15sDrgXQmW5DUZKOAsBUpYuRGH+6Hi0wN+UYzYs3f5L1JOUZYcJU0jFAOWrBXT
         OfNfcoeHUppyMuP67eYQkieaW1j8EVkGJg/3XQ7AmjQKTZ8LLJ+X1XAY6TjGINGfVEDH
         vKc89GIX7YJ8OpyxQIBjaOXLsbdx2E0j7r22IrUQF1vA18nVI2htrlCdfXYWMWIqF+3f
         uLuHXFZe9ehFoC5I9YRUENECt6hgY4mAW9p56RoL8kngpJhXTy5JwoqoTpbL+5/nG4Rd
         5DZfVQpbB1CjBEbxRZYFAxl2+1Hq7FF1tLZHaPI64lEl78EmdhpYjSgTzFNOz8xsymyI
         wJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698436441; x=1699041241;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BstzjcyRw76SGnx2Oi2IF7IWdWUB4/PFTixP0/vCToE=;
        b=UjGFl7OGWSTlHrDDksE8cwW7JttyP00cPfOcPCmRYKhWcIikc6/UiVnBMEURQ+APSR
         ntcdTs9surUXteZLnuHCwBFQhYohx+tFZ/yPLUJGAmZSyWjTlXeSg3Q0jj0YvqaHSxsn
         C23g7JX4cqQG0yLBa0ltWp9DscxmJ3DcNzBsTuD54xqM1J+Ma+6cQ6c310l+cHfdMwDv
         C2MzA2XHzdqrU1jy9L1IWAVy7kZX/RfHp7svPi9S9qgP+Ahub/4tBwXyIeeg37oJABMD
         KhlOAy9iYgimMsANhp7hm2rbQGA9vRz/ZIW6DRinAue3gBzJrEcxqOFRTKC8VjjhIOkx
         wQdQ==
X-Gm-Message-State: AOJu0Yy9M3UVuj71dartP2JO03vhLrdVM+AOm7T84YmNXRsh/pKdRtbc
        H2U1A9++kV0r8NdqS6jlN5lgnX3vYdChbdSEVCM1TA==
X-Google-Smtp-Source: AGHT+IFHe6YaVIZX9ufp2lRJ/R4i0AprIQrXuWsnel1YLkC+zMGpgM9zIdxi5N2WV+emXWs+wgwRFQ==
X-Received: by 2002:a17:90b:d8a:b0:280:259:435d with SMTP id bg10-20020a17090b0d8a00b002800259435dmr3597315pjb.4.1698436440968;
        Fri, 27 Oct 2023 12:54:00 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090a1a0a00b00274922d4b38sm1760076pjk.27.2023.10.27.12.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 12:54:00 -0700 (PDT)
Message-ID: <51149548-e214-426d-9e89-ceba050569ab@kernel.dk>
Date:   Fri, 27 Oct 2023 13:53:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 6.6-final
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just a single fix for a potential divide-by-zero, introduced in this
cycle. Please pull!


The following changes since commit c3414550cb0d4dfad1816ee14ff1f44819d270db:

  Merge tag 'nvme-6.6-2023-10-18' of git://git.infradead.org/nvme into block-6.6 (2023-10-18 15:32:51 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.6-2023-10-27

for you to fetch changes up to 2dd710d476f2f1f6eaca884f625f69ef4389ed40:

  blk-throttle: check for overflow in calculate_bytes_allowed (2023-10-20 18:38:17 -0600)

----------------------------------------------------------------
block-6.6-2023-10-27

----------------------------------------------------------------
Khazhismel Kumykov (1):
      blk-throttle: check for overflow in calculate_bytes_allowed

 block/blk-throttle.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
Jens Axboe

