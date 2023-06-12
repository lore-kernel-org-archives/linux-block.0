Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AF8C7EE2F
	for <linux-block@archiver.kernel.org>; Mon, 12 Jun 2023 18:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjFLSfi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Jun 2023 14:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbjFLSeo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jun 2023 14:34:44 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70F1E69
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 11:34:38 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6e68cc738so35364565e9.1
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 11:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686594877; x=1689186877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0IOWy1Q/nQ3vvc3NqtOdJTxE/lj89TxQGfmJuj8eq4=;
        b=rdZopJ1b6hkx8M3BLkjqUBcixkpXeNboW961IgX8x/J9nZ/xb0tMyCEPseOFjJhWdn
         7ZAfXS/UTcHXI5ycB3s/4rDbqGksl+5ey0evWS6JHjIBgn9FStjLNF1Gh30xHAm6ufH4
         qI1kYnGGb5RFZCIa5+/B8xMrdkUTiAL5D3yxPkiC9l1nl2xBba6VAJRx6LdtbSjfSVJ1
         do/Ed/3j5+0qfOmgedHjW50Qo4rrIErPm+lMc4uUDZTDJnK3TFbSSAjZJe9IOLNvPpLF
         OjbI0Z3j5rqqN16AuYa3GAjurV+kyMnNFusz30H0gllShURH1fKDFayyO0F461sztcd4
         1QqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686594877; x=1689186877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0IOWy1Q/nQ3vvc3NqtOdJTxE/lj89TxQGfmJuj8eq4=;
        b=Xb/upcDDDSOxCl9ApKNAPRjwK0u/Q091jGWkPG1HRx0/GaMv2iXJ0jXxNLLatL0rzz
         J/XMfCQOchaLmxakgms1e5EwBymsoZNFFyFGRLe58TbJks9/4wAjsCtJezAvYwMrt/E6
         tmkLtyTxWVuxUkiGdkaAoGLQhuAj1NpPgoWNe0HX44JHKJBcmj7Co9rdBtlLTqmq+K3Z
         5+5LmEB3eVqHfIcPxr5fmdeohqlElBXz4BIYSTjW63qcNZkmZW4AtGi5o76fU8nIoHSw
         iiEh6E+U4IiJe8m87+T6WsxzecWIFk/Tesya6gZHKmRhxhaT2msSgN/hLubbbqMHO62j
         Ozkw==
X-Gm-Message-State: AC+VfDzw9REq7fvUy4fUz/NaaEyQfNSZIVLOvo+ql6hk7nY4SYOtKulG
        r/9gKlPlorQ1czUKT7xjoDbVLUbNMmrF0NcGtUEJIw6R6pAolFpbRhM=
X-Google-Smtp-Source: ACHHUZ5cH+4gdxRh6mGKIsGNR68yFt95azKNVDTz/qTH5o8xuXb0T7aFOe/VRogrgh5DU5BQ9Hl+FwS/hWkGYLnw6EY=
X-Received: by 2002:adf:e9c9:0:b0:30f:bcf3:9a30 with SMTP id
 l9-20020adfe9c9000000b0030fbcf39a30mr3005478wrn.17.1686594877035; Mon, 12 Jun
 2023 11:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230522222554.525229-1-bvanassche@acm.org> <CAB=BE-SGR8xc9JOF2g4vGVYp0MRmV1pG2WLjoWo3YwAGL1LKJg@mail.gmail.com>
 <6240756d-718a-ccfa-e479-9a3f7a26244a@acm.org>
In-Reply-To: <6240756d-718a-ccfa-e479-9a3f7a26244a@acm.org>
From:   Sandeep Dhavale <dhavale@google.com>
Date:   Mon, 12 Jun 2023 11:34:25 -0700
Message-ID: <CAB=BE-SmbYUcnKe-J6FF7Y30MOwturY=dqrP_buLhLvPR_fkrg@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Support limits below the page size
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, jyescas@google.com,
        mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 12, 2023 at 11:15=E2=80=AFAM Bart Van Assche <bvanassche@acm.or=
g> wrote:
>
> On 6/9/23 10:14, Sandeep Dhavale wrote:
> > We have tested this series on Pixel 6 by applying to android common
> > kernel at [0] successfully with 16K page size.
> >
> > Feel free to add
> > Tested-by: Sandeep Dhavale <dhavale@google.com>
>
> Thanks Sandeep for the testing. I assume that the Tested-by tag applies
> to patches 1, 2, 3 and 6 of this series?
>
That is correct Bart, those were the relevant patches for our testing
with 16KB page size. Sorry, I should have been more clear.

Thanks,
Sandeep.

> Thanks,
>
> Bart.
