Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33894C61D97
	for <linux-block@archiver.kernel.org>; Fri, 27 Jan 2023 08:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjA0Ig7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Jan 2023 03:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjA0Ig5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2023 03:36:57 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928804B4B0;
        Fri, 27 Jan 2023 00:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1674808615; x=1706344615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=AGGREt+2escCQOiULTNyB1cijMLnW4SEFao7tt1/88k=;
  b=f4uUuFetb0XcdyWYtCP772TUQAsY0mGVNlibfCJE87zoUiL8/TROGpgQ
   1ng1TSF5dB2Uifvyb5+RPH58oBDsS9cDaR6VAJY9hYhjci5E1fPJguOrM
   cPAScdLqTwjE8aYAyfMtQ5lMePPwzhRl12VoaGajZGvmn2YlnTSWnkWdx
   8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Jan 2023 00:36:55 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 00:36:55 -0800
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 27 Jan 2023 00:36:52 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <rdunlap@infradead.org>
CC:     <axboe@kernel.dk>, <corbet@lwn.net>, <linux-block@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/35] Documentation: block: correct spelling
Date:   Fri, 27 Jan 2023 14:06:44 +0530
Message-ID: <1674808604-13251-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20230127064005.1558-4-rdunlap@infradead.org>
References: <20230127064005.1558-4-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>Correct spelling problems for Documentation/block/ as reported
>by codespell.
>
>Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
