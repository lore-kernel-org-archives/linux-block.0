Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228ABC04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 15:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF10220892
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 15:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="jr/+8u23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF10220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeLEPeI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:34:08 -0500
Received: from mail-yw1-f48.google.com ([209.85.161.48]:45645 "EHLO
        mail-yw1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeLEPeI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 10:34:08 -0500
Received: by mail-yw1-f48.google.com with SMTP id d190so8679287ywd.12
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 07:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=82oU3z4BZSwRYa+Uo7SWtMn09ICjek6K+DzRgHwtl4U=;
        b=jr/+8u23P3qi+ep03yucujWx1MUwq8+JxAwrYq+7OxHTnjo1I47mY0hVxw8o1bs1w6
         HOuaOeXxUA8nzm6ZECLEnU+s6jC9q2JWXDuXHZAex2sg8x25zPc+6GSzEkgBMjYVyb+7
         KqVSbah5iIeMc8NnybdGMPygvaXNMW1dYqwqO3Vk4/eSRS7g3RYumwtWTJ4hQi58o5vf
         DEzJxcGysTv64NkJFnhBTj+nqtlTD/EPL3d9KejnYuXcpUjNJ8mXuf9duj+s+RMLFmRt
         c59CvBus4ysnxlfkjU3GUwh4SdSWVqRzWeVEpYaz2/KlFRXfmAGJIhVJigOjK+oNeK4J
         UEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=82oU3z4BZSwRYa+Uo7SWtMn09ICjek6K+DzRgHwtl4U=;
        b=sP2kMcQqFU+wZ+VkcQGK5xSx+vkUHnNipX+ToRbvOUY/izblV/6u7VvGFZWJ3vpzYr
         izy8QV3v80HcIY0VC2m6S0Vul+7ofrSA71pobGPNc6z6R2bn7bjh9Um+Ehj5kyxCA+Cj
         pGclwT8fSDXCmqT5VX2DE0egmsb0T3Ft4DDVjBtxRn2SnKB6jVz9bHH+mN/UeseMf8M4
         frAK+fmUNxUjZV32hr4P5tWiF19QwDrYrGFfQj5tffKb27NsmTmvZzptbW0JnVbU026+
         LqXzL8sli9u09oFv+pqIvQnMdd85FEHIBAC/FXCzIAz8w+hNTdgn5uRQQ0wp1V5fYJEZ
         jXSg==
X-Gm-Message-State: AA+aEWYAguI5l0dBk39MtkeZ9qeLhduSZbbMnoHSiEJYq7oU9uTJMCel
        eo4JNSboL6eSzUYk/vC8LV7Hwx72W1Y=
X-Google-Smtp-Source: AFSGD/X3rB/xruHDmwcHYm063t8/GA0Ts1ZUKXlOkBxa9laY2hJkv6trthmgioyThc310HiuFup+pw==
X-Received: by 2002:a0d:e381:: with SMTP id m123mr16248119ywe.163.1544024046800;
        Wed, 05 Dec 2018 07:34:06 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d85sm6851292ywd.22.2018.12.05.07.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 07:34:05 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-block@vger.kernel.org, kernel-team@fb.com, osandov@fb.com
Subject: [PATCH 0/2][V2] io.latency test for blktests
Date:   Wed,  5 Dec 2018 10:34:02 -0500
Message-Id: <20181205153404.26634-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

v1->v2:
- dropped my python library, TIL about jq.
- fixed the spelling mistakes in the test.

-- Original message --

This patchset is to add a test to verify io.latency is working properly, and to
add all the supporting code to run that test.

First is the cgroup2 infrastructure which is fairly straightforward.  Just
verifies we have cgroup2, and gives us the helpers to check and make sure we
have the right controllers in place for the test.

The second patch brings over some python scripts I put in xfstests for parsing
the fio json output.  I looked at the existing fio performance stuff in
blktests, but we only capture bw stuff, which is wonky with this particular test
because once the fast group is finished the slow group is allowed to go as fast
as it wants.  So I needed this to pull out actual jobtime spent.  This will give
us flexibility to pull out other fio performance data in the future.

The final patch is the test itself.  It simply runs a job by itself to get a
baseline view of the disk performance.  Then it creates 2 cgroups, one fast and
one slow, and runs the same job simultaneously in both groups.  The result
should be that the fast group takes just slightly longer time than the baseline
(I use a 15% threshold to be safe), and that the slow one takes considerably
longer.  Thanks,

Josef
