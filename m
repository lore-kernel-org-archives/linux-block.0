Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B19173;
	Tue,  3 Dec 2024 00:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733184714; cv=none; b=f2Jm8SpbNfed6yAOJXqEr6Bjh+vEiyfq38mveA/Kx243eqXAZuevrCML7X7YA4b2fm9FcEdpQSLHylUiS1vb/aZ4As4qem60avIwby/dp6zmQix/rM2njVyIZjujVeE7WtWrbtJ3GcOgjcryclku71vg9Y+npxbtX9e2Fa6wwKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733184714; c=relaxed/simple;
	bh=ow+zWbQweIAuNl4Su7qk5EX3gpm4kMrbYNuFNjhZSHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X45aapIMqJp2bRAiankj1G7/DYESNk4AEXuDfW3rr1arkwoUC6zwp/Bwe0a3FwRQcxiV37s5jom5WIhPKEIWrnjSKLFEXPhImctkawIGx0DznjceQRblENoe6L5XxyhjSe6XRPLBwaMMqZNmTAFoZ7JzPoM2CqXhqCxcGeWa7i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aDSI65nh; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aDSI65nh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733184713; x=1764720713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ow+zWbQweIAuNl4Su7qk5EX3gpm4kMrbYNuFNjhZSHY=;
  b=aDSI65nhHXh4aAq/mIHuKDxF+ydmOQI8epvC3ZjuG/ukq95BtvJG36Pc
   5vGoVbp0nlKT0CJmu7zB9JUNMc2bBRbWjz5DTEDb8xEXPf0CPpH1d8wEi
   k/f3bc3b1JBAzo9VajsHgZGWL/bif4enUUvASrq4Xb9f7QWPMDlYfCK/1
   Tl/Jy5taSvy8sd0uko6ZM9Hjv4tTayC0YU6pAwo7cbV7Mm+6WzhMoJtaq
   Ui+LqwmZ8IOJcangBeEVXObRZzXa0ZWLRPnlFtsZjgHr5Gb1U73YZIATL
   Ws1axk1wHQ0o41oKsYX38WFfr6Pr5R0gj0SiL0l49GLZQDsJ/5ykMpqC1
   Q==;
X-CSE-ConnectionGUID: B7m+DBCmT8e8yca9Qw7z+A==
X-CSE-MsgGUID: HycnrI9lTiObaB3qUpoSpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="36233205"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="36233205"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 16:11:52 -0800
X-CSE-ConnectionGUID: CmkdaC4oTp+1o4OEq1/jRg==
X-CSE-MsgGUID: G/8VFtyyRMGnLf0dl8ms8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98278120"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 02 Dec 2024 16:11:45 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIGVu-00033p-2y;
	Tue, 03 Dec 2024 00:11:40 +0000
Date: Tue, 3 Dec 2024 08:11:03 +0800
From: kernel test robot <lkp@intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Asutosh Das <quic_asutoshd@quicinc.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Gaurav Kashyap <quic_gaurkash@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev
Subject: Re: [PATCH RESEND v7 11/17] soc: qcom: ice: add support for
 generating, importing and preparing keys
Message-ID: <202412030742.vCplCxJb-lkp@intel.com>
References: <20241202-wrapped-keys-v7-11-67c3ca3f3282@linaro.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202-wrapped-keys-v7-11-67c3ca3f3282@linaro.org>

Hi Bartosz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on f486c8aa16b8172f63bddc70116a0c897a7f3f02]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/blk-crypto-add-basic-hardware-wrapped-key-support/20241202-201228
base:   f486c8aa16b8172f63bddc70116a0c897a7f3f02
patch link:    https://lore.kernel.org/r/20241202-wrapped-keys-v7-11-67c3ca3f3282%40linaro.org
patch subject: [PATCH RESEND v7 11/17] soc: qcom: ice: add support for generating, importing and preparing keys
config: i386-buildonly-randconfig-006-20241203 (https://download.01.org/0day-ci/archive/20241203/202412030742.vCplCxJb-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412030742.vCplCxJb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412030742.vCplCxJb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/soc/qcom/ice.c:528: warning: Function parameter or struct member 'ice' not described in 'qcom_ice_import_key'


vim +528 drivers/soc/qcom/ice.c

   512	
   513	/**
   514	 * qcom_ice_import_key() - Import a raw key for inline encryption
   515	 * ice: ICE driver data
   516	 * @imp_key: raw key that has to be imported
   517	 * @imp_key_size: size of the imported key
   518	 * @lt_key: longterm wrapped key that is imported, which is
   519	 *          BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE in size.
   520	 *
   521	 * Make a scm call into trustzone to import a raw key for storage encryption
   522	 * and generate a longterm wrapped key using hwkm.
   523	 *
   524	 * Return: 0 on success; -errno on failure.
   525	 */
   526	int qcom_ice_import_key(struct qcom_ice *ice, const u8 *imp_key, size_t imp_key_size,
   527				u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
 > 528	{
   529		size_t wk_size = QCOM_ICE_HWKM_WRAPPED_KEY_SIZE(ice->hwkm_version);
   530	
   531		if (!qcom_scm_import_ice_key(imp_key, imp_key_size, lt_key, wk_size))
   532			return wk_size;
   533	
   534		return 0;
   535	}
   536	EXPORT_SYMBOL_GPL(qcom_ice_import_key);
   537	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
