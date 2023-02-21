Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E936EC61DA3
	for <linux-block@archiver.kernel.org>; Tue, 21 Feb 2023 15:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbjBUPAI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Feb 2023 10:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbjBUPAG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Feb 2023 10:00:06 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD4D2B603
        for <linux-block@vger.kernel.org>; Tue, 21 Feb 2023 06:59:52 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l1so4477149wry.10
        for <linux-block@vger.kernel.org>; Tue, 21 Feb 2023 06:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYgal4JxSeqClDjOaTIWuG632pDj7jRjSVKH768J0cA=;
        b=PDqFr7rK7Vsizp2SoUOAuwuQDMnOpklEDFWI62I9nYYSPDrpQa9ctbnm/jfxP8mXBq
         a1gdys5zn4lYWlrUJrczRrMm/vTHTTTmt3FJnDb/c0NxXI6ogZNSXryLk/6QqNHL+GuI
         jqnWWAF8Nk4N7trprqi5/nlrgpAMFc97H4u0G3KsqvDjg9jOQwPzCx5AxW4R/tV7eue/
         ZxTeas/snD63Wu1jsPKPIxFoeC2K/P11Dhfoboo6p2/8amrIAeI0NuBpufz7nPnPAgxY
         MzpLyrnSXXsZohr+sWnpAuodwZAK9+pRqk1fsTBRKRwHEfuAAlbUo5pAoam6db/Ct2Tn
         1RNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZYgal4JxSeqClDjOaTIWuG632pDj7jRjSVKH768J0cA=;
        b=u9HP3lq8mh5AF32j8aWYqY0aizek/2IsmdrfRpFzv3r1odyePL1sf0srUsy37FvBsS
         XeTCVOa4SQnKJxGoq/w+RsVVCMOQBSjgZBbosZMWOlUVd8rv+ToCk4X2F2D9WtWs9IKs
         ppeIp5K+Ffd/AghaXqQIjttnzf/21z/koNr5TbxYPNtA9j1pYEYhqi2VGbn5xaHZkk3D
         1mNWmY3tfQhHCO++D/2sZuR3WbmRCZVw5Lfl4tij8pd0IKP5Jbyg4RsiXhcqzcTtY+rP
         3DqSDoo9PA5xPmpcHYih7GsYq/eRoZWwEmZn/YIE3wKCcg/2pIjluhSv7vBXp8PrmPQJ
         Z6hg==
X-Gm-Message-State: AO0yUKVNfHGNfMU9LF/c3743u7xTi+IZx/wfjpUwZZ8nSePD7D21YSEd
        cPgPOWMSxFvPBraC2XOi+rhMWzGRHA==
X-Google-Smtp-Source: AK7set9hwTFESFknaE4VxvM4+v6baf3xj9i3QS2s1+5ZJDuY71sp3PvxESPhmeDwThxxF0/o+ew/Sg==
X-Received: by 2002:a5d:69cd:0:b0:2c5:9ef9:9bab with SMTP id s13-20020a5d69cd000000b002c59ef99babmr4020127wrw.43.1676991590363;
        Tue, 21 Feb 2023 06:59:50 -0800 (PST)
Received: from DESKTOP-L1U6HLH ([39.42.138.70])
        by smtp.gmail.com with ESMTPSA id x15-20020adff64f000000b002c406b357cfsm5829940wrp.86.2023.02.21.06.59.49
        for <linux-block@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 21 Feb 2023 06:59:50 -0800 (PST)
Message-ID: <63f4dc66.df0a0220.e2bdc.0c7f@mx.google.com>
Date:   Tue, 21 Feb 2023 06:59:50 -0800 (PST)
X-Google-Original-Date: 21 Feb 2023 09:59:51 -0500
MIME-Version: 1.0
From:   butler.dreamlandestimation@gmail.com
To:     linux-block@vger.kernel.org
Subject: Building Estimates
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,=0D=0A=0D=0AIn case you really want take-offs for a developmen=
t project, we ought to be your consultancy of decision. Reach out=
 to us assuming that you have any undertakings for departure whic=
h could utilize our administrations.=0D=0A=0D=0ASend over the pla=
ns and notice the exact extent of work you need us to assess.=0D=0A=
We will hit you up with a statement on our administration charges=
 and turnaround time.=0D=0AIn case you endorse that individual st=
atement then we will continue further with the gauge.=0D=0A=0D=0A=
For a superior comprehension of our work, go ahead and ask us que=
stions .=0D=0A=0D=0AKind Regards=0D=0AButler Alexis	=0D=0ADreamla=
nd Estimation, LLC

