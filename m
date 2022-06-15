Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AAAC43334
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 00:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241830AbiFOAzX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 20:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbiFOAzW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 20:55:22 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233984D26E
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 17:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655254521; x=1686790521;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ntV/5FoEPm/UHGGZqKsqUnq+X6Ig/HI7BcccAzSoQBY=;
  b=HubpSaklDvjonM5Sd4JMUgL1zrtpR4M0U2t1nuZ+0drYF4hjqUL44Jb0
   lgqEKkB6lUgiuIc9HWLq872BD2FIShl+P8Gz70ElpbuZAWEsh8/aQKSH1
   5D4GBUOOCyyebA+RS3zHbF76p+bBoErJhu05y7hY7g/Lz4GSRtCRkQUui
   6J2wFuDtgMwvHfd+EJlbQD0Om3+T3t28dIsBtKfs2ObsdTWM1D765jrNF
   iD7yJMArBy0jAXO3wNz9TfWUVaFfY8d0cv8X2OxgaryuRcgTBa3h6RYxh
   UXaf0pGYLzhjczQWrUFLOzj4wh0aa+oFYjvPgBRcBbQq5naMb2mmHR/iQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,300,1647273600"; 
   d="scan'208";a="203171384"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2022 08:55:21 +0800
IronPort-SDR: Nhk6JVYHsRzOpVAeZLlZ/c/P1y3/6BQBqLu8XM+ICkHC2URdaqRc5PDSv42cLdf4MrU/4QWBp1
 IoSljWnR0/muwCp7Qu+PpTd3y1H+CSXvmsMrhyMm6cFGfZgrCM0a3LYmUPVRQ47HR+yM52/W3q
 PaR+IHoSDPBMhTz+wf5LsrUtPPYgueBoqR6ilU2kNz07jCctTEixxPza7bQHaF00INfZxUEguA
 8Z4kHkc1ZaYzRr+iv2Fk53QBbR5OcW0kVTn/siU2hKML+Szs+X7VoZZ5JUDJbWYSIkvoddId82
 +bL6kkXfRUvzY68vS07cB4Wf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 17:18:19 -0700
IronPort-SDR: Mf1ObSl62yjM1DsnHf+nkCjk5uT9VXHnNpWTvNOHuLo7azhPzUrfDdItqTyqRvVfQ1dh+G0lUK
 HLXeKnVD3kO4ZSD8YKzJJX2hVv0UTr9rSHiXaF8ftkuaFYHC7Z/Co6OchdgBOOidNpL99UxEbl
 S/vJVC05IgR+GkBaNcbqm9r9jWSEEbV4HBuSNlYfH4DwXWr7a7XGScRKcpy6WhKd/u92eqIJPu
 WMicL1gCiYsmbEkcl87ikJuU8ZulLzwcK9F+SEcJgBF06ZI643kpLhdVd4ZyHgdncC+QIn81Gi
 2F0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 17:55:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LN6Kj0R7pz1SVp1
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 17:55:21 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655254520; x=1657846521; bh=ntV/5FoEPm/UHGGZqKsqUnq+X6Ig/HI7Bcc
        cAzSoQBY=; b=JHiZlZLFa2j3cbzCAjdOooxPG2XshN+uEPct84LQAvwEetTZ99J
        k48/o8PPwhlbvpLn8tiz87RFZb6XaFtxTImrJvMtcNy0jHVWI204Z9slzIWyHU1j
        lnpvf0snNm/lYSfQXSjwfKt4/lCHoed8ofJARM95siiSVid4ZPSU00GyW3/DWvqV
        jgVLhjB+6I9KQbURUfIKgAq7moeiwu8Cbhfkes+BOwwLkJALrgQ23vdtVz993fPe
        FbZHLv1CF+THfyfCc62sxjp3mIPTWzc0yjBIRivlbPZ5oO0/Z0XMPez1o8D+kPNu
        KVMFFcZXOfYw96ET8tN2vrrvcgn44HJKc3Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id K30cRRNaOMzz for <linux-block@vger.kernel.org>;
        Tue, 14 Jun 2022 17:55:20 -0700 (PDT)
Received: from [10.225.163.82] (unknown [10.225.163.82])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LN6Kg1vR1z1Rvlc;
        Tue, 14 Jun 2022 17:55:19 -0700 (PDT)
Message-ID: <50bc28eb-4936-d3ac-d4f0-69ac2cca4b65@opensource.wdc.com>
Date:   Wed, 15 Jun 2022 09:55:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/5] scsi: Retry unaligned zoned writes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Khazhy Kumykov <khazhy@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220614174943.611369-1-bvanassche@acm.org>
 <20220614174943.611369-3-bvanassche@acm.org>
 <CACGdZYJ7HfykzbgiPpT7Ymd0h39qQE3qfz90QCNeoBjK04-HSw@mail.gmail.com>
 <186833db-bb36-e3c3-5670-ac8ff0b2906b@acm.org>
 <c8e55085-4b7d-ef11-a22a-39ac71e63227@opensource.wdc.com>
 <576762e9-eb93-0411-890e-0ed0764559ef@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <576762e9-eb93-0411-890e-0ed0764559ef@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/15/22 08:54, Bart Van Assche wrote:
> On 6/14/22 16:50, Damien Le Moal wrote:
>> We try that "fix" with the work for zoned btrfs. It does not work. Even
>> adding a delay to wait for out of order requests (if there is a hole in a
>> write sequence) does not reliably work as FSes may sometimes take 10s of
>> seconds to issue all write requests that can be all ordered into a nice
>> write stream. Even with that delay increased to minutes, we were still
>> seeing unaligned write errors.
> 
> Please clarify. Doesn't BTRFS use REQ_OP_ZONE_APPEND for zoned storage? 
> REQ_OP_ZONE_APPEND requests do not trigger write errors if reordered.

The trial I am mentioning above was before we moved to using zone append
and implementing scsi emulation for it.

Note that btrfs uses zone append write for data only. Metadata writes
still require regular write commands.

> 
> Additionally, our tests with F2FS on top of this patch series pass.

Try on an AHCI SMR drive and I am 100% sure that you will see unaligned
write errors.

> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research
