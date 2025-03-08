Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655B8C133
	for <linux-block@vger.kernel.org>; Sat,  8 Mar 2025 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741429556; cv=none; b=LWXlm1DOTYBwKH++pkBOloDtiPDpFxOv+FJ9OhfvJeySlEyd53Mc0Ol5snRuNDhhBIuhV+rLSe3kbPa223PONwteATTJTGsdi63A1pqIavImKx6C1p/B48x7BUDrxabf0EYh7ttg3jsUFF7GGX2/8AZ8lmNtMerWkKPk1qfT2rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741429556; c=relaxed/simple;
	bh=sSfs0T7ZNJti2sb9JggzV+ppgNYMACO1hUzUI8TJWAM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RbCO9lE6w2mIFH0MqrMzJdmth0PJTPXdbOd33r1r41P7bx+Hh/IXbI+SAYaj4YYDyreqpJCAGO6Pw/Vnda+JwunGzxeTZzJ1HTzYox7XJEE6uDRLHLEmho84ulHTyrxJ89lqtVYsJv0zP2mtg6ZxAGycLm4MmVjuK0XzPwokVXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BwrvSxod; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BwrvSxod"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bc30adad5so16141745e9.1
        for <linux-block@vger.kernel.org>; Sat, 08 Mar 2025 02:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741429553; x=1742034353; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bz0Bhd4Jvoy6VZO4mtNBH+o0oLJxgU/mLcExG7NuymI=;
        b=BwrvSxodXNB4Z52FTmux8nPSn1q1TeHYxTXcFerpYIZ+u3Tbg13mffK7MHYY5hcR1d
         L6EKuJ2t7PsSCdDMO8YIkyZhz6bkaxo6NrJQhRi4ynA4sweUoBHok3Ja1kUxxDFxuaXy
         I4RL3nIFLYiBtUc2YvyhOWeTgx7AxlNwpTK2SSkQ0W9ilWeFgqDDa6FsAEe8b6H49v5+
         zN9LiBsg8LTDPcn2OM5UKLCWL6DUqfl6yPNcXF+LnJVjkVXhRg5SPJyWgwZcwkp64sE+
         0nudG5RptT6BkZbQpOE1gvK4jVUzvKp+pF16P4ugC8hcqPPyUYxbRN/gKNgF4tmPD9eJ
         io+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741429553; x=1742034353;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bz0Bhd4Jvoy6VZO4mtNBH+o0oLJxgU/mLcExG7NuymI=;
        b=i2REhz25ow8tg0kzsfgTDOb/eQcqjL0OPr6u0OtEpwWMQuTBqaV/q612ZX0cwNZkeF
         oTkfVJGdpCynAeRGgj9VqelUaLs7wB9enYWXP2yOUiEDhdxYNqcNoOUgj9m8CdnIyQlA
         aiAHoHBrn9NAadxsftWy7krIAyjxqpa2QykcVfV20RaY6iLSScOwAvyuv+v4fZETIiE9
         lO2160GfiaaF0Rhqr/YZDmao+s4MKtSbxUuKN8iW0iGFebdyexiF2TYDwhKonUMLFslp
         eLvbyXw1hFUw0n/w/9FsMeEqqZ9treUpe0wLCAXPIraJM+HhFdVf3Mihbb2ljNsaIclJ
         JIxg==
X-Gm-Message-State: AOJu0YyDh+R2WXuv3VstHjBWiro7ZXeINOfrnL5HJcm46AUhkVGjhPw1
	GCfXCED6FSLhl7PKbKblb2p8LCrlDsHCzqHwcsSqi0E6XgPGN0JLV2/uCVG+WPo=
X-Gm-Gg: ASbGncv4CQtZzFPqikw0HYVNTY1CfQEp76Fl0sKw1iloc41K/LzTnornFGpnq5bp803
	aJ5//ESHX1pLP7Mtr6IaOlf53iv+ZR2A0tNExPtGE6bhdDIkMiKpxVJz3eQtFM53acmouPKfAeb
	FmhBg9fUHLpXCjWFp5hmDHiZP6GKCMAIU6bhBafdvfpJVrwPs96zQtHwR4/et4TP35p8KERFM14
	M+SAflyvopx1NnB4/vqb/nyqfrD75zDSlLInx8AOVobUumKjhgSSNP9rNB/Sk5vWYPIQ3dsHZP0
	f07759iGKEnn9ARYLjW7Lcbx9HShfKBly72DMCfOrMgfHjJmOg==
X-Google-Smtp-Source: AGHT+IFgSNjgRdM8+CGc1i0YUCVyeEq9BKAX3b112WXNWrw0o1oqqiHm1ms7W+tA9RzgN/WzHmv7Jw==
X-Received: by 2002:a05:600c:4fc8:b0:43c:e9f7:d6a3 with SMTP id 5b1f17b1804b1-43ce9f7da7emr10249605e9.13.1741429552627;
        Sat, 08 Mar 2025 02:25:52 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bd42c588dsm106904075e9.21.2025.03.08.02.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 02:25:52 -0800 (PST)
Date: Sat, 8 Mar 2025 13:25:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Coly Li <colyli@suse.de>
Cc: linux-block@vger.kernel.org
Subject: [bug report] badblocks: improve badblocks_check() for multiple
 ranges handling
Message-ID: <c8e4f72d-7a9f-428d-a67b-41ddd4da8f2f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Coly Li,

Commit 3ea3354cb9f0 ("badblocks: improve badblocks_check() for
multiple ranges handling") from Aug 12, 2023 (linux-next), leads to
the following Smatch static checker warning:

	block/badblocks.c:1251 _badblocks_check()
	warn: unsigned 'sectors' is never less than zero.

block/badblocks.c
    1186 static int _badblocks_check(struct badblocks *bb, sector_t s, sector_t sectors,
                                                                       ^^^^^^^^^^^^^^^^
sector_t is u64.

    1187                             sector_t *first_bad, sector_t *bad_sectors)
    1188 {
    1189         int prev = -1, hint = -1, set = 0;
    1190         struct badblocks_context bad;
    1191         int unacked_badblocks = 0;
    1192         int acked_badblocks = 0;
    1193         u64 *p = bb->page;
    1194         int len, rv;
    1195 
    1196 re_check:
    1197         bad.start = s;
    1198         bad.len = sectors;
    1199 
    1200         if (badblocks_empty(bb)) {
    1201                 len = sectors;
    1202                 goto update_sectors;
    1203         }
    1204 
    1205         prev = prev_badblocks(bb, &bad, hint);
    1206 
    1207         /* start after all badblocks */
    1208         if ((prev >= 0) &&
    1209             ((prev + 1) >= bb->count) && !overlap_front(bb, prev, &bad)) {
    1210                 len = sectors;
    1211                 goto update_sectors;
    1212         }
    1213 
    1214         /* Overlapped with front badblocks record */
    1215         if ((prev >= 0) && overlap_front(bb, prev, &bad)) {
    1216                 if (BB_ACK(p[prev]))
    1217                         acked_badblocks++;
    1218                 else
    1219                         unacked_badblocks++;
    1220 
    1221                 if (BB_END(p[prev]) >= (s + sectors))
    1222                         len = sectors;
    1223                 else
    1224                         len = BB_END(p[prev]) - s;
    1225 
    1226                 if (set == 0) {
    1227                         *first_bad = BB_OFFSET(p[prev]);
    1228                         *bad_sectors = BB_LEN(p[prev]);
    1229                         set = 1;
    1230                 }
    1231                 goto update_sectors;
    1232         }
    1233 
    1234         /* Not front overlap, but behind overlap */
    1235         if ((prev + 1) < bb->count && overlap_behind(bb, &bad, prev + 1)) {
    1236                 len = BB_OFFSET(p[prev + 1]) - bad.start;
    1237                 hint = prev + 1;
    1238                 goto update_sectors;
    1239         }
    1240 
    1241         /* not cover any badblocks range in the table */
    1242         len = sectors;
    1243 
    1244 update_sectors:
    1245         s += len;
    1246         sectors -= len;
                 ^^^^^^^^^^^^^^
Subtraction.

    1247 
    1248         if (sectors > 0)
    1249                 goto re_check;
    1250 
--> 1251         WARN_ON(sectors < 0);
                         ^^^^^^^^^^^

    1252 
    1253         if (unacked_badblocks > 0)
    1254                 rv = -1;
    1255         else if (acked_badblocks > 0)
    1256                 rv = 1;
    1257         else
    1258                 rv = 0;
    1259 
    1260         return rv;
    1261 }

regards,
dan carpenter
