Return-Path: <SRS0=leUH=UL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C7FC31E46
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 13:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D08B208CA
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 13:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560346772;
	bh=rvQHIt4GDLlwdBbXUsexskN3ra7CEvqVLZaJHG0Q+FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fa4G7cMZFjvessU95ekWzwbG38o1o8bQYiwezKzsnRcJ0ngiP5LepcFy9J5oh2TIG
	 yau5Dr1KrvvYp34J28jt17me2U+ovnGlkJfl09EHoiF0/1F2BwQvTCHkHe84PfzdMo
	 k+XQmxh1dqwtMHzDgXaVRyxSoKrXiSj9cyhENsBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408433AbfFLNjb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jun 2019 09:39:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46450 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407111AbfFLNjb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jun 2019 09:39:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id 81so9677931pfy.13
        for <linux-block@vger.kernel.org>; Wed, 12 Jun 2019 06:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q2Ae324CKt2gt5FPiDITS3acqtACPG+wGKF0qDOwCvQ=;
        b=kNwNQ2W9hQYdzRU+sjZ09+Nx5q6etOLPgOPSWPzJnekCyQtdheWlCUeuzSHedoErWp
         Ar66X/1qOqHE2rkmqbbXEa8jrq+1hMP7hyxuXLogJEAB4hcbvHs6gjxoVVFkFR1LsDaK
         vjcYgCf0stnl+QEtn1q56hQ5NRrRmdiqulZHoIeB5uoWg7BQdDHrYkmoecCglZ/vHuHi
         0jJCJos2fRx+GU05n1rskvFleA4S4FLYlcPAAQwAIJ3mKm5VW31cMZJeAB/JSCZnqTcZ
         pQKQLhvxAIuOwbd9XFL+tUjInAihgesFfbgd8SLBit7kz2CpCdxz5xjW35unj2N9xj9U
         7LAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=q2Ae324CKt2gt5FPiDITS3acqtACPG+wGKF0qDOwCvQ=;
        b=oYazj7Z25hYaZtFIyNbSS6vvQ9quRxT0FZVdpFzHj6MxvK8j7uTgJcjOiQkeLMF/rA
         jke6/9m65msWoclgHeTrXChmjmmNRbcfq3iaR0DNKaau1X6FQEJjTi6fW3jl/Eg1IfgA
         J7GManEUdrEYgjabowGMcTpxuomK8IqNurRoFnkDkUUW9jkENatYsEuuz806QgqZmJ9v
         m/YkKk8/PhCMaDt6uTsmKEyzMppe0t/p8ri8WwqkDu3rZNlM3QlvncGgga2o+DQOfEdR
         Uf42+gfcWVQWw0w8X3KL2RxSZH/7/PrmI33AKspu8AXtq5J4fWADY/TOhjGFFjWVAS4i
         epnA==
X-Gm-Message-State: APjAAAXZjXBb6z60wvA9vR5Mhid1AxPVCGMhGW83piyxMnqWwqgmU9KE
        HgBUcnA97msy6W+Fyc4ig18=
X-Google-Smtp-Source: APXvYqz6Ev+sAnu5DHm+qhzh0Z+KkUnSJa62xPMZIYMz4oIH1jzNnQWScdjL6OnbKRljrA8jceqBgQ==
X-Received: by 2002:a17:90a:af8a:: with SMTP id w10mr33401750pjq.132.1560346770510;
        Wed, 12 Jun 2019 06:39:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::c431])
        by smtp.gmail.com with ESMTPSA id m14sm6960660pgl.35.2019.06.12.06.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 06:39:28 -0700 (PDT)
Date:   Wed, 12 Jun 2019 06:39:26 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH block/for-5.2-fixes] bfq: use io.weight interface file
 instead of io.bfq.weight
Message-ID: <20190612133926.GN3341036@devbig004.ftw2.facebook.com>
References: <4f801c9b-4ab6-9a11-536c-ff509df8aa56@kernel.dk>
 <CAHk-=whXfPjCtc5+471x83WApJxvxzvSfdzj_9hrdkj-iamA=g@mail.gmail.com>
 <52daccae-3228-13a1-c609-157ab7e30564@kernel.dk>
 <CAHk-=whca9riMqYn6WoQpuq9ehQ5KfBvBb4iVZ314JSfvcgy9Q@mail.gmail.com>
 <ebfb27a3-23e2-3ad5-a6b3-5f8262fb9ecb@kernel.dk>
 <90A8C242-E45A-4D6E-8797-598893F86393@linaro.org>
 <20190610154820.GA3341036@devbig004.ftw2.facebook.com>
 <20190611194959.GJ3341036@devbig004.ftw2.facebook.com>
 <20190611211718.GM3341036@devbig004.ftw2.facebook.com>
 <A1C3E3D8-62E3-4BD3-86B4-59E7E1319EA8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A1C3E3D8-62E3-4BD3-86B4-59E7E1319EA8@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 12, 2019 at 09:32:07AM +0200, Paolo Valente wrote:
> Could you elaborate a little more on this?

Doesn't seem like you did.

> bfq code for setting up and handling io.weight (more precisely
> io.bfq.weight) is a copy and paste of cfq code.

Please take a look at the documentations under
Documentation/cgroup-v1/blk-iocontroller.txt and
Documentation/admin-guide/cgroup-v2.rst.

Thanks.

-- 
tejun
