Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A3AEB64D7
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 16:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245181AbjFPQPQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 12:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344784AbjFPQOp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 12:14:45 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC7E3C3A
        for <linux-block@vger.kernel.org>; Fri, 16 Jun 2023 09:14:15 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3420d8ad7feso242755ab.0
        for <linux-block@vger.kernel.org>; Fri, 16 Jun 2023 09:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686932055; x=1689524055;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qedg+C6ew2ndpIdTS3WRAhgGJHCHkVBs8xH6FiGnB/A=;
        b=gh0486XcKCOTJbT1tCboydVB9ei03UgA/kozG282bW2lj7wMCSOxrl4VbSeuFi48At
         Sg14jmvpid6SLyYqxjfeNlVDApOl4c2r6d0xbnTRKO7HydYaNNsQkrZ9EI6yL968qYb6
         dJL98bBZtFWaVmu3DPXIKhF6DadlmWz6wWRpz3tlCGnMNx7ijjbJRSOTvndZYJDRFzSu
         ifnxkXQ30rWZ4hly1+6w2SA9u5oEAaLTiO1oTmuUT2fKUg7wUMgZRj/TLUOJR2awVeus
         b0pdTsYOk6s8lAGsluLSGGzMy9ZIYK+WAudJIoTy+6Jdyf0THfVIfIA1gRv+3+vTsZlM
         6F3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686932055; x=1689524055;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qedg+C6ew2ndpIdTS3WRAhgGJHCHkVBs8xH6FiGnB/A=;
        b=DywZH81IPundVd/Pm3yxE6Qb1V/7ziDSrelQal6t7i59F0pIi/dNwLOqxegzaxqTma
         oQ8/Xv7ji8rX+fobRkGWkyn3Z677YMmx/KLhnWfIAsOlWFn4BZyR0hlXSewwIELJtyiu
         a9TdZEGEQzlmj00DuI9/QFhIm7CDpXSMg4IdFNANEDtXlKcD7PU0Ag6ShH+wmIMKJ/DQ
         Bn3X8LhAGafp/H4EQhU34bWWk1Lv0ibQW6aO8u2p0C7fVdDnBnBSiFS6dMh5AmgTRN4M
         uprvJd9sXG2wOcl/2qt0XFZpx9ex338GCE2JkVwx3qO2WE4ikgxeAFs8gU6fqbslEezt
         A+6A==
X-Gm-Message-State: AC+VfDzR9NZUauI1hBprAuJXcyN3sXn0Qi/xSqgl1Jcn9iVal00UENbE
        SMOEqU9SaNXMh/RuzYfnSYngF87E+oN+KAkkPkc=
X-Google-Smtp-Source: ACHHUZ5RMMYvUn6MCA7+kkNrdKMjndhaqVsoP7cN7t+JLbf3LCVyqqL1iC7xk58fCB+J80a+u1rOhA==
X-Received: by 2002:a92:740d:0:b0:338:4b36:5097 with SMTP id p13-20020a92740d000000b003384b365097mr2769600ilc.1.1686932054814;
        Fri, 16 Jun 2023 09:14:14 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y16-20020a92c750000000b0033e62b47a49sm6786006ilp.41.2023.06.16.09.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 09:14:14 -0700 (PDT)
Message-ID: <2045ee6e-6d52-deae-462b-1f87f8bab305@kernel.dk>
Date:   Fri, 16 Jun 2023 10:14:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 6.4-rc7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just a single fix for blk-cg stats flushing. Please pull!


The following changes since commit ccc45cb4e7271c74dbb27776ae8f73d84557f5c6:

  s390/dasd: Use correct lock while counting channel queue length (2023-06-09 11:35:52 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.4-2023-06-15

for you to fetch changes up to 20cb1c2fb7568a6054c55defe044311397e01ddb:

  blk-cgroup: Flush stats before releasing blkcg_gq (2023-06-11 19:49:29 -0600)

----------------------------------------------------------------
block-6.4-2023-06-15

----------------------------------------------------------------
Ming Lei (1):
      blk-cgroup: Flush stats before releasing blkcg_gq

 block/blk-cgroup.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

-- 
Jens Axboe

