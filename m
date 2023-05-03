Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E76C77B7F
	for <linux-block@archiver.kernel.org>; Wed,  3 May 2023 15:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjECPKY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 May 2023 11:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjECPKX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 11:10:23 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299B94ED2
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 08:10:22 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f132fae59fso256265e87.0
        for <linux-block@vger.kernel.org>; Wed, 03 May 2023 08:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683126620; x=1685718620;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1FOOYbd4dNFDyiEsaPE2X+b61t9SVPlgw+HWMJw8nPQ=;
        b=TnQK1tdn3LLc0dafPNxyDu3yFLk4cSqjY4YNnUNKhYS757CIc18Uzuq+EdX+lSiNdn
         ZG2ty+SqrMWpaLjASeiGW4wTam8ZAlS5PtDJhx/ljbLcrmrLMPEiNNRg+igLYKOwdxg9
         +6DVcLdzYoStMlUV5OwZfGhQ5YCi8r3hbsbido/aGmJ0MR6r39LuuJ32iYrtBDKUddM2
         W8d4QavGKciKDb6oWng/dwHdPzSTLojEmZkDwZHcVqWeBduzK/i9B4jM97gbrNq3htM5
         5JXcaYPV3/uFHHc9d5Bi9ZSnJNpfZoTNr8rE4wizZetLd8slHwdZlQsc2uJvRg9L4gcC
         X21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683126620; x=1685718620;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1FOOYbd4dNFDyiEsaPE2X+b61t9SVPlgw+HWMJw8nPQ=;
        b=b+/v5b5cLYeYxW0mnY4djAfQv0ZoUEbcLglxqtnBvfyBoIgm34y93tQCfd3jIzx3kc
         Ggk2HltS6krGiK1Pwo0fWokZe4O5oD4Shkxzfwl8QHm+HrCal9OB0t211yvu0ZRbdL8y
         5zy3bA/nHpY1sfmYVRrGyLQyklk/7VczNe6WpTGvcTtdiL+LfM2yiBtoHdL4GeYBwcJ+
         m+bOTgZFsTzbFmukrBqT8ExNJPfp7sQ+sbKE8JUqEW0KkwIBoC6WDXfxIL0TvM0WQXkT
         7d729SLZceVsB31cHONAsUNmGHzo/1My5sMWmbzHJwQGxRN1qnC1/2fh5VIBcJtvVYGA
         2+5g==
X-Gm-Message-State: AC+VfDwOrqQ8LJCHbo7wOYigoVdg6Azj1CD0V2PUE0VMOB32a3/626/X
        nCU4m+kYGOfGFJcjInp8yE/Okr66gu0=
X-Google-Smtp-Source: ACHHUZ4Kyf1aScNS050khyEIs7/zXRdYsIclsaKZSl3K0iZbf4F2vY/JUbmHIIwZZmP9av8hURcKwA==
X-Received: by 2002:a19:7419:0:b0:4ec:89d3:a89d with SMTP id v25-20020a197419000000b004ec89d3a89dmr4497102lfe.4.1683126620046;
        Wed, 03 May 2023 08:10:20 -0700 (PDT)
Received: from DESKTOP-BKF2J9E ([203.109.40.79])
        by smtp.gmail.com with ESMTPSA id j1-20020a19f501000000b004eff0bcb276sm4824521lfb.7.2023.05.03.08.10.18
        for <linux-block@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 03 May 2023 08:10:19 -0700 (PDT)
Message-ID: <6452795b.190a0220.561f0.cfee@mx.google.com>
Date:   Wed, 03 May 2023 08:10:19 -0700 (PDT)
X-Google-Original-Date: 3 May 2023 20:10:19 +0500
MIME-Version: 1.0
From:   erwinshrader438@gmail.com
To:     linux-block@vger.kernel.org
Subject: Estimating Services
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

=0D=0AHi,=0D=0A=0D=0AWe are an estimating firm and offer our serv=
ices to GC's, Sub Contractors and Architects. We perform commerci=
al and residential estimates & takeoffs.=0D=0A=0D=0AIf you have a=
ny job for estimating or designing just send over the project pla=
ns/details after reviewing the drawings, We will give you 85% off=
 market price. You may also ask us for samples of our recent work=
.=0D=0A=0D=0AThanks.=0D=0ARegards,=0D=0AErwin Shrader=0D=0AMarket=
ing Manager=0D=0ACrown Estimation, LLC

